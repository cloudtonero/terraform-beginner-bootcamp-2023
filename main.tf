terraform {
  required_providers {
    terratowns = {
      source  = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}
provider "terratowns" {
  endpoint  = "http://localhost:4567/api"
  user_uuid = "e328f4ab-b99f-421c-84c9-4ccea042c7d1"
  token     = "9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}

#terraform {
#cloud {
# organization = "Mrtonero_app"

#workspaces {
# name = "terra-house-007"
#}
#}
#}

# module "terrahouse_aws" {
#   source = "./modules/terrahouse_aws"
#   user_uuid = var.user_uuid
#   bucket_name = var.bucket_name
#   index_html_filepath = var.index_html_filepath
#   error_html_filepath = var.error_html_filepath
#   content_version = var.content_version
#   assets_path = var.assets_path

# }

resource "terratowns_home" "arcanum"{
  name = "How to play Arcanum in 2023!--aa!"
  description = <<DESCRIPTION
Arcanum is a game from 2001 that shipped with alot of bugs.
Modders have removed all the original issues , making this game fun to play
(Despite the old graphics ). This is my guild that will show you how to play arcanum.
without spoiling the plot.
DESCRIPTION
  town = "gamers-grotto"
  content_version =  1
  //domain_name = module.terrahouse_aws.cdn_domain_name
  domain_name = "3xxx.cloudfront.net"
  
}