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
output "route53_zone_zone_ids" {
  description = "Zone ID of Route53 zones"
  value       = module.zone.route53_zone_zone_id
}

output "route53_zone_zone_arns" {
  description = "Zone ARNs of Route53 zone"
  value       = module.zone.route53_zone_zone_arn
}

output "route53_zone_name_servers" {
  description = "Name servers of Route53 zone"
  value       = module.zone.route53_zone_name_servers
}

output "route53_zone_names" {
  description = "Names of Route53 zone"
  value       = module.zone.route53_zone_name
}

output "route53_static_zone_names" {
  description = "Names of Route53 zone created statically to avoid invalid count argument error when creating records and zones simmultaneously"
  value       = module.zone.route53_static_zone_name
}
