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

locals {

  default_tags = {
    provisioner = "Terraform"
  }

  # This module allows creation of one zone while the parent module accepts a map of zones, hence this conversion
  mandatory = {
    domain_name   = var.zone_name
    comment       = var.comment
    force_destroy = var.force_destroy
  }
  optional_vpc = {
    vpc = {
      vpc_id     = var.vpc_id
      vpc_region = var.region
    }
  }

  t = merge(local.mandatory, var.vpc_id == "" ? {} : local.optional_vpc)
  zone = {
    (var.zone_name) = local.t
  }

  resource_name = module.resource_names["dns_zone"].standard

  tags = merge(local.default_tags, var.tags)
}
