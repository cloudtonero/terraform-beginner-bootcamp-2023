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