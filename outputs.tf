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
output "zone_id" {
  value = module.zone.route53_zone_zone_id[var.zone_name]
}

output "zone_arn" {
  value = module.zone.route53_zone_zone_arn[var.zone_name]
}

output "name_servers" {
  value = module.zone.route53_zone_name_servers[var.zone_name]
}

output "zone_name" {
  value = var.zone_name
}

output "zone_resource_name" {
  value = local.resource_name
}
