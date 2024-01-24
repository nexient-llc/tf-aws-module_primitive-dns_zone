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

# Variables required by the DNS zone module
variable "zones" {
  description = "Map of Route53 zone parameters"
  type = map(object({
    domain_name   = string
    comment       = string
    force_destroy = optional(bool, false)
    tags          = optional(map(string))
    vpc = optional(list(object({
      vpc_id     = optional(string)
      vpc_region = optional(string)
    })), [])
  }))
  default = {}
}
variable "create" {
  description = "Whether to create Route53 zone"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags added to all zones. Will take precedence over tags from the 'zones' variable"
  type        = map(string)
  default     = {}
}
