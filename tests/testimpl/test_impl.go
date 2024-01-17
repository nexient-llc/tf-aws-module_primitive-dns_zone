package common

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/nexient-llc/lcaf-component-terratest-common/lib/aws/dns"
	"github.com/nexient-llc/lcaf-component-terratest-common/types"
	"github.com/stretchr/testify/assert"
)

func TestComposableComplete(t *testing.T, ctx types.TestContext) {

	t.Run("TestIsZoneExist", func(t *testing.T) {
		zone_id := terraform.Output(t, ctx.TerratestTerraformOptions, "zone_id")
		expected_zone_name := ctx.TestConfig.(*ThisTFModuleConfig).Zone_name
		zone := dns.GetHostedZoneById(t, zone_id)
		assert.Equal(t, *zone.HostedZone.Name, dns.NameNormalize(expected_zone_name))
	})
}

func TestNonComposableComplete(t *testing.T, ctx types.TestContext) {
	if !ctx.IsCurrentTest("public_zone") {
		t.SkipNow()
	}
	t.Run("TestIsRecordExists", func(t *testing.T) {
		if !testDataHaveDNSRecords(t, ctx) {
			t.SkipNow()
		}
		zone_id := terraform.Output(t, ctx.TerratestTerraformOptions, "zone_id")
		for _, rec := range ctx.TestConfig.(*ThisTFModuleConfig).Records {
			fullQualifiedRecordName := rec.Name + "." + dns.NameNormalize(ctx.TestConfig.(*ThisTFModuleConfig).Zone_name)
			_, err := dns.LookupDNSRecordInPublicRoute53ZoneByDNSProtocol(t, zone_id, fullQualifiedRecordName, rec.Type)
			assert.NoError(t, err, "can not find expected DNS record in AWS DNS: "+fullQualifiedRecordName)
		}

	})
}

func testDataHaveDNSRecords(t *testing.T, ctx types.TestContext) bool {
	return len(ctx.TestConfig.(*ThisTFModuleConfig).Records) > 0
}
