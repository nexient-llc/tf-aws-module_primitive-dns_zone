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

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.19.0"

  name                 = var.vpc_name
  cidr                 = var.vpc_cidr
  private_subnets      = var.private_subnets
  azs                  = var.availability_zones
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = var.tags
}

module "dns_zone" {
  source = "../.."

  naming_prefix      = var.naming_prefix
  environment        = var.environment
  environment_number = var.environment_number
  resource_number    = var.resource_number
  region             = var.region
  resource_names_map = var.resource_names_map
  zone_name          = var.zone_name
  comment            = var.comment
  force_destroy      = var.force_destroy
  vpc_id             = module.vpc.vpc_id

  tags = var.tags
}
