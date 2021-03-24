resource "azurerm_resource_group" "rg" {
    name        = "${var.Tags["App"]}-rg-${local.region}-${terraform.workspace}"
    location    = var.Location
    tags        = local.tags
}

module "vmcollection1" {
    source          = "../TerraformModules/Modules/VirtualMachine"
    Location        = var.Location
    ResourceGroup   = azurerm_resource_group.rg.name
    AdminPassword   = random_password.randpw.*.result
    Subnet          = azurerm_subnet.snet.id
    Nsg             = azurerm_network_security_group.nsg.id
    Tags            = local.tags
    Size            = var.vmcollection1["Size"]
    OsDiskType      = var.vmcollection1["DiskType"]
    OsDiskSize      = var.vmcollection1["DiskSize"]
    VmImage         = var.vmcollection1["Image"]
    DomainPassword  = data.azurerm_key_vault_secret.domain.value
    Project         = "${var.Tags["App"]}"
    Environment     = terraform.workspace
    VmCount         = var.vmcollection1["Count"]
    AvailabilitySet = false
}

