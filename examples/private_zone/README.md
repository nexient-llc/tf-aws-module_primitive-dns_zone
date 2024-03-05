# AWS Route53 Private Zone
This module will provision a Private Hosted Zone with all its dependencies like VPC. This example demostrated deployment of multiple private dns zones in same VPC.

## Pre-requisites
- Need to create a `provider.tf` with below contents
    ```
    provider "aws" {
      profile = "<profile-name>"
      region  = "<aws-region>"
    }
    ```
- Command to execute the module
  `terraform apply -var-file test.tfvars`
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.28.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | git::https://github.com/nexient-llc/tf-module-resource_name.git | 1.0.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 5.5.2 |
| <a name="module_dns_zone"></a> [dns\_zone](#module\_dns\_zone) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-module-resource\_name to generate resource names | <pre>map(object({<br>    name       = string<br>    max_length = optional(number, 60)<br>    region     = optional(string, "us-east-2")<br>  }))</pre> | `{}` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Project environment | `string` | `"dev"` | no |
| <a name="input_environment_number"></a> [environment\_number](#input\_environment\_number) | The environment count for the respective environment. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_resource_number"></a> [resource\_number](#input\_resource\_number) | The resource count for the respective resource. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region in which the infra needs to be provisioned | `string` | `"us-east-2"` | no |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | `"network"` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | Map of Route53 zone parameters | <pre>map(object({<br>    domain_name   = string<br>    comment       = string<br>    force_destroy = optional(bool, false)<br>    tags          = optional(map(string))<br>    vpc = optional(list(object({<br>      vpc_id     = optional(string)<br>      vpc_region = optional(string)<br>    })), [])<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags added to all zones. Will take precedence over tags from the 'zones' variable | `map(string)` | `{}` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | # VPC related variables | `string` | `"test-vpc-015932020"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | n/a | `string` | `"10.1.0.0/16"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of private subnet cidrs | `list(string)` | <pre>[<br>  "10.1.1.0/24",<br>  "10.1.2.0/24",<br>  "10.1.3.0/24"<br>]</pre> | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of availability zones for the VPC | `list(string)` | <pre>[<br>  "us-east-2a",<br>  "us-east-2b",<br>  "us-east-2c"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route53_zone_zone_ids"></a> [route53\_zone\_zone\_ids](#output\_route53\_zone\_zone\_ids) | Zone IDs of Route53 zone |
| <a name="output_route53_zone_zone_arns"></a> [route53\_zone\_zone\_arns](#output\_route53\_zone\_zone\_arns) | Zone ARNs of Route53 zone |
| <a name="output_route53_zone_name_servers"></a> [route53\_zone\_name\_servers](#output\_route53\_zone\_name\_servers) | Name servers of Route53 zone |
| <a name="output_route53_zone_names"></a> [route53\_zone\_names](#output\_route53\_zone\_names) | Names of Route53 zone |
| <a name="output_route53_static_zone_names"></a> [route53\_static\_zone\_names](#output\_route53\_static\_zone\_names) | Names of Route53 zone created statically to avoid invalid count argument error when creating records and zones simultaneously |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
