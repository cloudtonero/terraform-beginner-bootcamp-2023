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

