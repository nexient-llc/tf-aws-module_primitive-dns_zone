locals {

  # Create resource name tags for the DNS zones
  resource_names_map = merge(var.resource_names_map, {
    for k, v in var.zones : "dns_zone_${k}" => {
      name       = "publiczone${index(keys(var.zones), k)}"
      max_length = 80
      region     = "us-east-2"
    }
  })

  # Merge the tags from the zones variable with the resource name tags and then merge with the zones variable
  tags = {
    for k, v in var.zones : k => {
      tags = merge(v.tags, {
        resource_name = module.resource_names["dns_zone_${k}"].standard
      })
    }
  }

  zones = {
    for k, v in var.zones : k => {
      domain_name   = v.domain_name
      comment       = v.comment
      force_destroy = v.force_destroy
      tags          = local.tags[k].tags
      vpc           = v.vpc
    }
  }
}
