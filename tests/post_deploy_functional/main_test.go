package main

import (
	"testing"

	"github.com/nexient-llc/lcaf-component-terratest-common/lib"
	"github.com/nexient-llc/lcaf-component-terratest-common/types"
	testimpl "github.com/nexient-llc/tf-aws-collection_module-dns_zone/tests/testimpl"
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
