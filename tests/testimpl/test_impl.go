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
		zone_ids := terraform.OutputMap(t, ctx.TerratestTerraformOptions, "route53_zone_zone_ids")
		for zone_name := range zone_ids {
			expected_zone_name := ctx.TestConfig.(*ThisTFModuleConfig).Zones[zone_name].Domain_name
			zone := dns.GetHostedZoneById(t, zone_ids[zone_name])
			assert.Equal(t, *zone.HostedZone.Name, dns.NameNormalize(expected_zone_name))
		}
	})
}

func TestNonComposableComplete(t *testing.T, ctx types.TestContext) {
	t.Run("TestIsRecordExists", func(t *testing.T) {
		if !testDataHaveDNSRecords(t, ctx) {
			zone_ids := terraform.OutputMap(t, ctx.TerratestTerraformOptions, "route53_zone_zone_ids")
			for zone_name := range zone_ids {
				for _, rec := range ctx.TestConfig.(*ThisTFModuleConfig).Records {
					fullQualifiedRecordName := rec.Name + "." + dns.NameNormalize(ctx.TestConfig.(*ThisTFModuleConfig).Zones[zone_name].Domain_name)
					_, err := dns.LookupDNSRecordInPublicRoute53ZoneByDNSProtocol(t, zone_ids[zone_name], fullQualifiedRecordName, rec.Type)
					assert.NoError(t, err, "can not find expected DNS record in AWS DNS: "+fullQualifiedRecordName)
				}
			}
		}

	})
}

func testDataHaveDNSRecords(t *testing.T, ctx types.TestContext) bool {
	return len(ctx.TestConfig.(*ThisTFModuleConfig).Records) > 0
}
