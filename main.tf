terraform {
  required_providers {
    terratowns = {
      source  = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  cloud {
    organization = "Mrtonero_app"
    workspaces {
      name = "Terrahome"
    }
  }
}


provider "terratowns" {
  endpoint  = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token     = var.terratowns_access_token
}



module "home_arcanum" {
  source          = "./modules/terrahome_aws"
  user_uuid       = var.teacherseat_user_uuid
  public_path     = var.arcanum.public_path
  bucket_name     = var.bucket_name
  content_version = var.arcanum.content_version 

}

resource "terratowns_home" "arcanum" {
  name            = "How to play Arcanum in 2023!--aa!"
  description     = <<DESCRIPTION
God of War Ragnarök is an action-adventure game developed by Santa Monica Studio and published by Sony Interactive Entertainment. It was released worldwide on November 9, 2022, for both the PlayStation 4 and PlayStation 5, marking the first cross-gen release in the God of War series. It is the ninth installment in the series, the ninth chronologically, and the sequel to 2018's God of War. Loosely based on Norse mythology, the game is set in ancient Scandinavia and features series protagonist, Kratos, and his now teenage son, Atreus. Concluding the Norse era of the series, the game covers Ragnarök, the eschatological event which is central to Norse mythology and was foretold to happen in the previous game after Kratos killed the Aesir god Baldur.
DESCRIPTION
  town            = "gamers-grotto"
  content_version = var.arcanum.content_version
  domain_name     = module.home_arcanum.cdn_domain_name
}



module "home_akara" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.akara.public_path
  bucket_name = var.bucket_name
  content_version = var.akara.content_version 

}



resource "terratowns_home" "akara"{
  name = "How to make Akara A.K.A Beans Cake"
  description = <<DESCRIPTION
How to make Akara: The setup on this one is extra-simple:
1. Soak for about 30 minutes or till the skin swells.
2. Peel off the beans with your hands (the hard way) or use a blender and pulse a couple of times to split the beans (the easy way)
3. Blend the peeled beans with peppers, crayfish, salt, and bouillon powder (or cube).
4. Whisk until the batter becomes airy and fluffy. This will take about a minute to 5 minutes depending on the tool you use. Electric hand 5. whisk takes about a minute to two, regular hand whisk will take about 2 to 3 minutes.
6. Stir in the diced onions.
7. Preheat the oil and scoop the mixture by spoonfuls into the pan
8. Fry till golden brown!
DESCRIPTION
  town = "cooker-cove"
  content_version =  var.akara.content_version
  domain_name = module.home_akara.cdn_domain_name
}