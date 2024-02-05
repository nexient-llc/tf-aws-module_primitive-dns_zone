# tf-aws-module_primitive-dns_zone

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This terraform module creates a Route53 Hosted Zone/s in AWS. This module can be used to provision both `private` and `public` hosted zones. A non empty `vpc` input variable indicates that the zone is private else it will be provisioned as public.

A sample input variable for deploying public zones would look like:

```
zones = {
  "<first_zone_domain_name>" = {
    domain_name   = "<first_zone_domain_name>"
    comment       = "<description>"
    force_destroy = true
    tags          = { "key" = "value" }
    vpc = {
      vpc_id     = <vpc id>
      vpc_region = <vpc region>
    }
  },
  "<second_zone_domain_name>" = {
    domain_name   = "<first_zone_domain_name>"
    comment       = "<description>"
    force_destroy = true
    tags          = { "key" = "value" }
    vpc = {
      vpc_id     = <vpc id>
      vpc_region = <vpc region>
    }
  }
}
```

A sample input variable for deploying public zones would look like:

```
zones = {
  "<first_zone_domain_name>" = {
    domain_name   = "<first_zone_domain_name>"
    comment       = "<description>"
    force_destroy = true
    tags          = {}
    vpc = {}
  },
  "<second_zone_domain_name>" = {
    domain_name   = "<second_zone_domain_name>"
    comment       = "<description>"
    force_destroy = true
    tags          = {}
    vpc = {}
  }
}
```

## Usage
A sample variable file `example.tfvars` is available in the root directory which can be used to test this module. User needs to follow the below steps to execute this module
1. Update the `example.tfvars` to manually enter values for all fields marked within `<>` to make the variable file usable
2. Create a file `provider.tf` with the below contents
   ```
    provider "aws" {
      profile = "<profile_name>"
      region  = "<region_name>"
    }
    ```
   If using `SSO`, make sure you are logged in `aws sso login --profile <profile_name>`
3. Make sure terraform binary is installed on your local. Use command `type terraform` to find the installation location. If you are using `asdf`, you can run `asfd install` and it will install the correct terraform version for you. `.tool-version` contains all the dependencies.
4. Run the `terraform` to provision infrastructure on AWS
    ```
    # Initialize
    terraform init
    # Plan
    terraform plan -var-file example.tfvars
    # Apply (this is create the actual infrastructure)
    terraform apply -var-file example.tfvars -auto-approve
   ```
## Known Issues
1. Not yet tested to provision public hosted zone

## Pre-Commit hooks

[.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to terraform, golang and common linting tasks. There are no custom hooks added.

`commitlint` hook enforces commit message in certain format. The commit contains the following structural elements, to communicate intent to the consumers of your commit messages:

- **fix**: a commit of the type `fix` patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
- **feat**: a commit of the type `feat` introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
- **BREAKING CHANGE**: a commit that has a footer `BREAKING CHANGE:`, or appends a `!` after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.
- **build**: a commit of the type `build` adds changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **chore**: a commit of the type `chore` adds changes that don't modify src or test files
- **ci**: a commit of the type `ci` adds changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- **docs**: a commit of the type `docs` adds documentation only changes
- **perf**: a commit of the type `perf` adds code change that improves performance
- **refactor**: a commit of the type `refactor` adds code change that neither fixes a bug nor adds a feature
- **revert**: a commit of the type `revert` reverts a previous commit
- **style**: a commit of the type `style` adds code changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **test**: a commit of the type `test` adds missing tests or correcting existing tests

Base configuration used for this project is [commitlint-config-conventional (based on the Angular convention)](https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional#type-enum)

If you are a developer using vscode, [this](https://marketplace.visualstudio.com/items?itemName=joshbolduc.commitlint) plugin may be helpful.

`detect-secrets-hook` prevents new secrets from being introduced into the baseline. TODO: INSERT DOC LINK ABOUT HOOKS

In order for `pre-commit` hooks to work properly

- You need to have the pre-commit package manager installed. [Here](https://pre-commit.com/#install) are the installation instructions.
- `pre-commit` would install all the hooks when commit message is added by default except for `commitlint` hook. `commitlint` hook would need to be installed manually using the command below

```
pre-commit install --hook-type commit-msg
```

## To test the resource group module locally

1. For development/enhancements to this module locally, you'll need to install all of its components. This is controlled by the `configure` target in the project's [`Makefile`](./Makefile). Before you can run `configure`, familiarize yourself with the variables in the `Makefile` and ensure they're pointing to the right places.

```
make configure
```

This adds in several files and directories that are ignored by `git`. They expose many new Make targets.

2. The first target you care about is `env`. This is the common interface for setting up environment variables. The values of the environment variables will be used to authenticate with cloud provider from local development workstation.

`make configure` command will bring down `aws_env.sh` file on local workstation. Developer would need to modify this file, replace the environment variable values with relevant values.

These environment variables are used by `terratest` integration suit.

Then run this make target to set the environment variables on developer workstation.

```
make env
```

3. The first target you care about is `check`.

**Pre-requisites**
Before running this target it is important to ensure that, developer has created files mentioned below on local workstation under root directory of git repository that contains code for primitives/segments. Note that these files are `aws` specific. If primitive/segment under development uses any other cloud provider than AWS, this section may not be relevant.

- A file named `provider.tf` with contents below

```
provider "aws" {
  profile = "<profile_name>"
  region  = "<region_name>"
}
```

- A file named `terraform.tfvars` which contains key value pair of variables used.

Note that since these files are added in `gitignore` they would not be checked in into primitive/segment's git repo.

After creating these files, for running tests associated with the primitive/segment, run

```
make check
```

If `make check` target is successful, developer is good to commit the code to primitive/segment's git repo.

`make check` target

- runs `terraform commands` to `lint`,`validate` and `plan` terraform code.
- runs `conftests`. `conftests` make sure `policy` checks are successful.
- runs `terratest`. This is integration test suit.
- runs `opa` tests

# Know Issues
Currently, the `encrypt at transit` is not supported in terraform. There is an open issue for this logged with Hashicorp - https://github.com/hashicorp/terraform-provider-aws/pull/26987

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, <= 1.5.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_zone"></a> [zone](#module\_zone) | terraform-aws-modules/route53/aws//modules/zones | ~> 2.11.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_zones"></a> [zones](#input\_zones) | Map of Route53 zone parameters | <pre>map(object({<br>    domain_name   = string<br>    comment       = string<br>    force_destroy = optional(bool, false)<br>    tags          = optional(map(string))<br>    vpc = optional(list(object({<br>      vpc_id     = optional(string)<br>      vpc_region = optional(string)<br>    })), [])<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags added to all zones. Will take precedence over tags from the 'zones' variable | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route53_zone_zone_ids"></a> [route53\_zone\_zone\_ids](#output\_route53\_zone\_zone\_ids) | Zone IDs of Route53 zones |
| <a name="output_route53_zone_zone_arns"></a> [route53\_zone\_zone\_arns](#output\_route53\_zone\_zone\_arns) | Zone ARNs of Route53 zone |
| <a name="output_route53_zone_name_servers"></a> [route53\_zone\_name\_servers](#output\_route53\_zone\_name\_servers) | Name servers of Route53 zone |
| <a name="output_route53_zone_names"></a> [route53\_zone\_names](#output\_route53\_zone\_names) | Names of Route53 zone |
| <a name="output_route53_static_zone_names"></a> [route53\_static\_zone\_names](#output\_route53\_static\_zone\_names) | Names of Route53 zone created statically to avoid invalid count argument error when creating records and zones simmultaneously |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

DELETEME