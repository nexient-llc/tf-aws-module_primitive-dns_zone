package main

import (
	"testing"

	testimpl "github.com/nexient-llc/tf-aws-module_primitive-dns_zone/tests/testimpl"

	"github.com/nexient-llc/lcaf-component-terratest-common/lib"
	"github.com/nexient-llc/lcaf-component-terratest-common/types"
)

const (
	testConfigDefault         = "../../examples"
	infraTFVarFileNameDefault = "test.tfvars"
)

func TestDNSZoneModule(t *testing.T) {
	//to implement non destructive tests for this TF module first
	ctx := types.TestContext{
		TestConfig: &testimpl.ThisTFModuleConfig{},
	}
	lib.RunNonDestructiveTest(t, testConfigDefault, infraTFVarFileNameDefault, ctx, testimpl.TestComposableComplete)
}
