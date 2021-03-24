Tags = {
    Project                     = "LogicMonitor"
    App                         = "logicmonitor"
    Contact = {
        Name                    = "CloudOps"
        Email                   = "CloudOps@britinsurance.com"
    }
    Costcentre                  = "N37"
    Description                 = "Sandbox LM Collector"
    Repo                        = "britgroupservices/BluePrints/Sandbox-LM-Collector"
    BusinessName                = "LogicMonitor"
}

Location                        = "UK South"

vmcollection1 = {
    Size                        = "Standard_B2ms"
    DiskType                    = "Standard_LRS"
    DiskSize                    = 127
    Image = {
        Publisher               = "MicrosoftWindowsServer"
        Offer                   = "windowsserver"
        Sku                     = "2019-Datacenter"
        Version                 = "latest"
    }
    Count                           = 1
}

Network = {
    RouteTable = {
        Name                    = "platform-rt-uks-nonprod"
        ResourceGroup           = "platform-rg-uks-nonprod"
    }
    Vnet = {
        Name                    = "platform-vnet01-uks-nonprod"
        ResourceGroup           = "platform-rg-uks-nonprod"
    }
    Subnet                      = ["10.9.27.0/27"]
    Nsg = {
        Rules = {
            Description         = ["all"]
            Direction           = ["inbound"]
            Protocol            = ["tcp"]
            Access              = ["allow"]
            SourcePrefix        = ["*"]
            SourcePorts         = ["*"]
            DestinationPrefix   = ["*"]
            DestinationPorts    = ["*"]
        }
    }
}

KeyVault = {
    Domain = {
        Name                    = "platform-kv-uks-nonprod"
        ResourceGroup           = "platform-rg-uks-nonprod"
        Key                     = "DomainJoin"
    }
    Admin = {
        Name                    = "platform-kv-uks-nonprod"
        ResourceGroup           = "platform-rg-uks-nonprod"
    }
}
