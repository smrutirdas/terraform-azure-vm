provider "azurerm" {
	version = "~>2.0"
	subscription_id = var.subscriptionID
	client_id = var.clientID
	client_secret = var.clientSecret
	tenant_id = var.tenantID

  features {}
}

resource "azurerm_resource_group" "terraformDemo" {
  name      = var.RGName
  location  = var.location
}
resource   "azurerm_virtual_network"   "myvnet"   { 
   name   =   "my-vnet" 
   address_space   =   [ "10.0.0.0/16" ] 
   location   =   var.location
   resource_group_name   =   var.RGName
 } 

 resource   "azurerm_subnet"   "frontendsubnet"   { 
   name   =   "frontendSubnet" 
   resource_group_name   =    var.RGName
   virtual_network_name   =   azurerm_virtual_network.myvnet.name 
   address_prefix   =   "10.0.1.0/24" 
 }
resource   "azurerm_public_ip"   "myvm1publicip"   { 
   name   =   "pip1" 
   location   =   var.location
   resource_group_name   =    var.RGName
   allocation_method   =   "Dynamic" 
   sku   =   "Basic" 
 }

resource   "azurerm_network_interface"   "myvm1nic"   { 
   name   =   "myvm1-nic" 
   location   =   var.location
   resource_group_name   =   var.RGName

   ip_configuration   { 
     name   =   "ipconfig1" 
     subnet_id   =   azurerm_subnet.frontendsubnet.id 
     private_ip_address_allocation   =   "Dynamic" 
     public_ip_address_id   =   azurerm_public_ip.myvm1publicip.id 
   } 
 }
resource   "azurerm_windows_virtual_machine"   "example"   { 
   name                    =   "myvm1"   
   location                =   var.location 
   resource_group_name     =   var.RGName
   network_interface_ids   =   [ azurerm_network_interface.myvm 1 nic.id ] 
   size                    =   "Standard_B1s" 
   admin_username          =   "adminuser" 
   admin_password          =   "Password123!" 

   source_image_reference   { 
     publisher   =   "MicrosoftWindowsServer" 
     offer       =   "WindowsServer" 
     sku         =   "2019-Datacenter" 
     version     =   "latest" 
   } 

   os_disk   { 
     caching             =   "ReadWrite" 
     storage_account_type   =   "Standard_LRS" 
   } 
 }
