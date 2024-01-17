naming_prefix = "demo_test"
zone_name     = "launch.nttdata.test.com"
comment       = "Test to create a public hosted zone through terraform"
force_destroy = true
tags = {
  "demoCostCenter" = "DemoValue"
}
