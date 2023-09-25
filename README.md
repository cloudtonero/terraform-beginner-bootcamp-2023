# Terraform Beginner Bootcamp 2023

# Week- 0 

The terraform installation script within the gitpod.yaml file encountered an issue. The terraform task in gitpod.yaml reached a point where it required user input. The objective is to ensure that the script runs smoothly without any need for user interaction.

below is the yaml task.

```yaml

tasks:
  - name: terraform
    init: |
      sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
      curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
      sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
      sudo apt-get update && sudo apt-get install terraform
```
The script also had  some key deprecation which was also an issue in the during the installation.

## Reinstalltion Terraform with the Latest Version.

Going through the the terraform installation instruction which can be found in (terraform.io) a new set of installation guild was found.

## Install Terraform CLI

### Considerations with the Terraform CLI Changes

The terraform CLI Installation have changed due to a gpg keystring being depreciated so i had to refer to the terraform cli installation guild to see the latest installtions guild

[Install Terraform ClI](https://developer.hashicorp.com/terraform/downloads)


### Consideration for Linux Distribution
This project is built against Ubuntu.
Please consider checking your linux distribution and change according to your distribution needs.
[How to Check OS Version In Linux](https://www.tecmint.com/check-linux-os-version/#:~:text=The%20best%20way%20to%20determine,on%20almost%20all%20Linux%20systems.)

### Refactoring into bash scripts.
While fixing the terraform gpg deprecation issues i noticed the new terraform installation bash-script had a considerable amount of 
more code so we had to pass it as a bash script called "Install_terraform_cli" 

This bash script can be found here : [install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod.yaml task file ([.gitpod.yaml](./gitpod.yaml)) tidy
- This will make it easier for me to debug and execute the terraform cli script
- This will allow better portability for other project that need to install terraform cli

#### Shebang
A shebang (pronounce sha-bang) tells the bash script what program to use when interpretting the script eg : `#!/usr/bin/bash`

ChatGpt Recommended this format for bash: `#!/usr/bin/env bash`

- for portability for different OS distribution
- Will search user's PATH for the base executable

#### Executuion Considerations.
WHen executing a bash script we can use `./` shorthand notation to execute the bash script.
e.g `./bin/install_terraform_cli`
If we are using a script in gitpod.yam, we need to point thwe script to a program that can interprete it.
e.g `source ./bin/install_terraform_cli`

#### Linux Permission COnsiderations

In order to make the bash script executable, we need to change linix permission for the script to be executable at the user's level.

```sh
chmod u+x ./bin/install_terraform_cli
```

we could also alternatively :
```sh
chmod 744 ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/chmod

### Gitpod lifecycle (Before, Init, command)

We need to be careful when using the Init because it will not run if we restart an existing workspace. 

https://gitpod.io/docs/configure/workspaces/tasks


### Working with Env Vars

we can list out all environment variables (ENV Vars) using the `env` command 

We can filter specific env using grep eg. `env | grep AWS_`

#### Setting and Unsetting Env VArs

in the terminal we can set env using `export HELLO='World'`

In the terminal we can unset an env using : `unset HELLO`

we can set an env var temporarily when running a command 

```sh
HELLO='World' ./bin/print_message
```

With a bash script we can set env without writting export eg .

```sh
#!/usr/bin/env bash

HELLO='World'

echo $HELLO
```
#### Printing Env Vars

We can print an env var using echo  eg. `echo $HELLO`

#### Scoping OF Env Vars

When you open up new bash terminals in VSCODE it will not be aware of env vars that you have set in another window.

if you want env var to persist accross future bash terminal that are open you would need to set the env vars inside your bash profile eg . `.bash_profile`

#### Persisting ENv in Gitpod

We can persist env vars in gitpod by storing them in gitpod secret storage.

```sh
gp env HELLO='World'
```
All future workspaces launched will set the env vars for all the bash terminal opennin those workspaces 

You can also set env in the `.gitpod.yam` but this can only contain non-sensitive env vars.

### AWS CLI Installtion

AWS cli is installed for this project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[How to Install AWS Cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI ENV VARS](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our aws credential is configured properly by running the following 
AWS CLI command:
```sh
aws sts get-caller-identity
```

if it is successful you should see a json payload returned that blooks like this:

```json
{
 "UserId": "AIDFSJKRUUGKVHDKGJGHYR",
    "Account": "1234567891020",
    "Arn": "arn:aws:iam::1234567891020:user/mrtonero"
}
```

we'll need to generate AWS CLI credential from IAM User in order to use the AWS CLI


## Terraform Basics


### Terraform Registry

Terraform sources their providers and modules from the terraform registry which is located at the registry.
[registry.terraform.io](https://registry.terraform.io/)

- **PROVIDER**:   A `PROVIDER` in Terraform is a plugin that enables interaction with an API. This includes Cloud providers and Software-as-a-service providers. The providers are specified in the Terraform configuration code. They tell Terraform which services it needs to interact with.


- **MODULE**: A Terraform `MODULE` is a reusable and self-contained unit of infrastructure code in the Terraform infrastructure-as-code (IaC) tool. Terraform is used to define and manage infrastructure resources like virtual machines, databases, and networks by writing code in a declarative manner.


[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/latest)

### Terraform Console

We can see a list of the terraform command by simply typing `terraform`.

#### Terraform Init

This is a command that must be ran at the start of every terraform project or file. This command pull and download all the neccessary providers and plugins needed to run the terraform project like this :
`terraform init`.

#### Terraform Plan

The terraform plan command lets you to preview the actions Terraform would take to modify your infrastructure, or save a speculative plan which you can apply later. The function of terraform plan is speculative: you cannot apply it unless you save its contents and pass them to a terraform apply command e.g: `terraform plan`

When we run the terraform apply an output similar to this would be displayed below.

```sh
 # random_string.bucket_name1 will be created
  + resource "random_string" "bucket_name1" {
      + id          = (known after apply)
      + length      = 16
      + lower       = true
      + min_lower   = 0
      + min_numeric = 0
      + min_special = 0
      + min_upper   = 0
      + number      = true
      + numeric     = true
      + result      = (known after apply)
      + special     = false
      + upper       = true
    }

Plan: 1 to add, 0 to change, 1 to destroy.

Changes to Outputs:
  ~ random_bucket_name = "QW1aNZFYHhhm92lg" -> (known after apply)
```

#### Terraform Apply 

The **`terraform apply`** command performs a plan just like terraform plan does, but then actually carries out the planned changes to each resource using the relevant infrastructure provider's API. It asks for confirmation from the user before making any changes, unless it was explicitly told to skip approval.

if we want to automatically approve an apply we can provide the auto approve flag eg . **`terraform apply --auto-approve`**

#### Terraform Destroy
The terraform destroy(**`terraform destroy`**) command terminates resources managed by your Terraform project. This command is the inverse of terraform apply in that it terminates all the resources specified in your Terraform state. It does not destroy resources running elsewhere that are not managed by the current Terraform project.

You can also use the --auto-approve to give permission to destroy. eg
`terraform destroy --auto-approve`



#### Terraform Lock Files

**`.terraform.lock.hcl`**: terraform.lock.hcl file is designed to lock provider versions, not module versions. This is to ensure that every Terraform run uses the same provider versions, leading to consistent behavior.

The terraformlock file should be commited to our Version Control System (VCS) eg GitHub

#### Terraform STate file

**`.terraform.tfstate`** : The terraform state file, by default, is named terraform. tfstate and is held in the same directory where Terraform is run. It is created after running terraform apply . The actual content of this file is a JSON formatted mapping of the resources defined in the configuration and those that exist in your infrastructure.

This file **should not be commited to your VCS**

Note: If you loose this file, you will loose knowing the state of your infrastructure.

**`.terraform.tfstate.backup`** tfstate. backup file is a backup of the terraform. tfstate file. Terraform automatically creates a backup of the state file before making any changes to the state file. This ensures that you can recover from a corrupted or lost state file.

This is the previous state file of the .terraform.tfstate


#### Terraform Direcory

`.terraform` directory contain binary of terraform providers.




