zones = {
  "launch.nttdata.test-1p.com" = {
    domain_name   = "launch.nttdata.test-1.com"
    comment       = "Test to create a public hosted zone through terraform"
    force_destroy = true
    tags          = {}
  },
  "launch.nttdata.test-2o.com" = {
    domain_name   = "launch.nttdata.test-2.com"
    comment       = "Test to create a public hosted zone through terraform"
    force_destroy = true
  }
}
