data "azurerm_key_vault" "domain" {
    name                = var.KeyVault["Domain"]["Name"]
    resource_group_name = var.KeyVault["Domain"]["ResourceGroup"]
}

data "azurerm_key_vault_secret" "domain" {
    name                = var.KeyVault["Domain"]["Key"]
    key_vault_id        = data.azurerm_key_vault.domain.id
}

resource "random_password" "randpw" {
    length              = 30
    min_upper           = 1
    min_lower           = 1
    min_numeric         = 1
    min_special         = 1
}


data "azurerm_key_vault" "admin" {
    name                = var.KeyVault["Admin"]["Name"]
    resource_group_name = var.KeyVault["Admin"]["ResourceGroup"]
}

resource "azurerm_key_vault_secret" "admin" {
    name                = module.vmcollection1.VirtualMachineName[count.index]
    key_vault_id        = data.azurerm_key_vault.admin.id
    value               = random_password.randpw.result
    tags                = local.tags
    count               = var.vmcollection1["Count"]
}