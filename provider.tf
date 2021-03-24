terraform {
    required_version        = "~> 0.12"
    required_providers {
        azurerm             = "~> 2.0"
        random              = "~> 3.0.1"
    }
    backend "azurerm" {
        key                 = "sandbox-lm-collector.012.terraform.tfstate"
    }
}

provider "azurerm" {
    version                 = "~> 2.0"
    features {}
}

provider "random" {
    version                 = "~> 3.0"
}
