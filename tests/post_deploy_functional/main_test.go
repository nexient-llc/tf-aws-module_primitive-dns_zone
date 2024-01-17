package main

import (
	"testing"

	testimpl "github.com/nexient-llc/tf-aws-collection_module-dns_zone/tests/testimpl"
	"github.com/nexient-llc/tf-caf-terratest-common/lib"
	"github.com/nexient-llc/tf-caf-terratest-common/types"
)

const (
	testConfigsExamplesFolderDefault = "../../examples"
	infraTFVarFileNameDefault        = "test.tfvars"
)

func TestDNSZoneModule(t *testing.T) {

	ctx := types.TestContext{
		TestConfig: &testimpl.ThisTFModuleConfig{},
	}
	lib.RunSetupTestTeardown(t, testConfigsExamplesFolderDefault, infraTFVarFileNameDefault, ctx,
		testimpl.TestComposableComplete, testimpl.TestNonComposableComplete)
}
