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
The script also had  some key deprecation which was also an issue in the 