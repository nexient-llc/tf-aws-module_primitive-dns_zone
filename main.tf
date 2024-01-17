// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

# This module is used to add metadata tags (resource_name) to all the resources
module "resource_names" {
  source = "git::https://github.com/nexient-llc/tf-module-resource_name.git?ref=1.0.0"

  for_each = var.resource_names_map

  region                  = join("", split("-", each.value.region))
  class_env               = var.environment
  cloud_resource_type     = each.value.name
  instance_env            = var.environment_number
  instance_resource       = var.resource_number
  maximum_length          = each.value.max_length
  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service
}

module "zone" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 2.11.0"

  # The input variable for the parent module is plural `zones` but we are passing in a single zone
  zones = local.zone

  tags = merge(local.tags, { resource_name = module.resource_names["dns_zone"].standard })
}
