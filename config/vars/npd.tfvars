Tags = {
    Project                     = "LogicMonitor"
    App                         = "logicmonitor"
    Contact = {
        Name                    = "Terence"
        Email                   = "altostratus@gmx.co.uk"
    }
    Costcentre                  = "None"
    Description                 = "Sandbox LM Collector"
    Repo                        = "dev.azure.com/AltostratusUK/_git/LogicMonitorCollector"
    BusinessName                = "LogicMonitor"
}

Location                        = "East US"

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
        Name                    = "TRRouteTable"
        ResourceGroup           = "newterraformrg"
    }
    Vnet = {
        Name                    = "TRVnet"
        ResourceGroup           = "newterraformrg"
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
        Name                    = "newterraformrg"
        ResourceGroup           = "keyvaultresourcegroup"
        Key                     = "Password"
    }
    Admin = {
        Name                    = "AzureADAdmin"
        ResourceGroup           = "pkeyvaultresourcegroup"
    }
}
