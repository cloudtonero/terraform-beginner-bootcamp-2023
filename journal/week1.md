# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure 

Our root module structure is as follows:


```
PROJECT_ROOT
|
|-- main.tf           - everything else
|-- variable.tf       - stores the structures of input variables
|-- terraform.tfvars  - The data of variables we want to load into our terraform project
|-- providers.tf      - defined required providers and their configuration
|-- output.tf         - stores our outputs
|-- README.md         - required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and input variables 
### Terraform Cloud Variables

In terraform we can set two kind of variable
- Environment Variable - those you will set in the bash terminal eg AWS Credential
- Terraform variables - Those that you would normall set in your tfvar file

We can set terraform cloud variables to be sensitive so they are not shown visisbly in the UI

### Loading terraform Variables

[Terraform input variable](https://developer.hashicorp.com/terraform/language/values/variables)

### Var Flag
we can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform plan -var user_uuid="my-user_uuid"`

### var-file flag

- TODO: research the flag 

### terraform Tfvars

This is the default file to load in terraform file to load in terraform variable in blunk

### auto .tfvars
- TODO: research this functionality for terraform cloud.

### Order of terraform Variables
- TODO : document which terraform variables takes precedence

## Dealing with Configuration 

## What happens when we lose our state file?

If your loose your state file you most likely have to tear all your cloud infrastructure manually .
you can use terraform import, but i twont work on all cloud resources. you need to check the terraform providers documentation for which reosurces support import.


### fix missing resources with Terraform Import
`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/commands/import)
[AWS s3 bucket ](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)

### Fix Manual Configuration 


If someone goes and and delete or modifies cloud reosurces though clickops.

if we run `terraform plan` , it will attemot to put our infrastructure back into the expected state fixing Configuration Drift.

## Fix using Terraform Refresh
```sh
terraform apply -refresh-only -auto-approve
```




## Terraform Modules

### Terraform Module Structure 
It is recommended to place `modules` in a modules directory when locally developing a module but you can name whatever you like.



### Passing Input Variables

We can input variables to our modules.
The Modules have to declare the terraform variable in its own variables.tf file

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```


### Module Sources 

Using the source we can import the module from various places eg.
- locally
- Github
- Terraform Registry


```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```

## Consideration when Using ChatGpt to write Terraform

LLms like ChatGPT may not be trained on the latest documentation or information about terraform.
It may likely produce older examples that would be deprecated. Often Affecting providers

## Working with Files in Terraform

### Fileexists Function

This is a built in terraform function to check the existence of a file

eg:
```tf
condition = (fileexists(var.error_html_filepath))

```
https://developer.hashicorp.com/terraform/language/functions/fileexists

### filemd5

https://developer.hashicorp.com/terraform/language/functions/filemd5

### Path Variable

In Terraform there is a special variabled called path that allows us to reference local path:

- path.module = get the path of the current module
- path.root = Get the path for the root module of the configuration.

[Special Path Variables](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

source "aws_s3_object" "index-object" {
  bucket = aws_s3_bucket.website_bucket.id
  key    = "index.html"
  source = "${path.root}/public/index.html"
  etag = filemd5(var.index_html_filepath)
}

## Terraform Locals
locals allows us to define local variable. 
it can be very useful to transform data into another format and reference it as a variable.
```tf
locals {
  s3_origin_id = "MyS3Origin"
}

```

[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)



## Terraform Data Sources
This Allows us to source data from cloud resources.
This is useful when we want to reference cloud resources without referencing them

```tf
data "aws_caller_identity" "current" {}
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```


[Terraform Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## working with json

We use the jsonencode to create the json policy inline in hcl for our s3 bucket

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}

```
[jsonencode Function](https://developer.hashicorp.com/terraform/language/functions/jsonencode)


### Changing the Life Cycle of Resources 

[Meta Argument Lifecycles](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

[](https://developer.hashicorp.com/terraform/language/resources/terraform-data)