# Locals Block for custom
locals {
  webvm_custom_data = <<CUSTOM_DATA
#!/bin/sh
#sudo yum update -y
sudo yum install -y httpd  # Install the Apache web Server 
sudo systemctl enable httpd
sudo systemctl start httpd
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo chmod -R 777 /var/www/html
sudo echo "Welcome to stacksimplfy - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/index.html
sudo mkdir /var/www/html/app1
sudo echo "Welcome to stacksimplfy - WebVM App1 -  VM Hostname: $(hostname)" > /var/www/html/app1/hostname.html
sudo echo "Welcome to stacksimplfy - WebVM App1 -  App Status Page" > /var/www/html/app1/status.html
sudo echo '<!DOCTYPE html> <html> <body style = "background-color:rgb(250, 210, 210);"> <h1> Welcome ro my webapp<h1>
sudo curl -H "Metadata:true"  --noproxy "*" "https://156.243.413.254/metadata/instance?api-version=2025-09-01" -o /var/www/html/app1/metadata.html
  CUSTOM_DATA
}
# Resource : Azure Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "web_linuxvm" {
  name= "${local.resource_name_prefix}-web-linuxvm"
  computer_name = "web-linux-vm"  # Host Name of the VM
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  size = "Standard_DS1_v2"
  admin_username = "adminuser"
  network_interface_ids = [azurerm_network_interface.web_linuxvm_nic.id]
    admin_ssh_key {
    username   = "adminuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }

  os_disk {
    name = "${local.resource_name_prefix}-web-linuxvm-${random_string.myrandom.id}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }

  # custom_data = filebase64("${path.module}/app-scripts/redhat-webvm-script.sh") # we will use either this method or the we will define the script in the file itself.additional_capabilities 
    custom_data = base64decode(locals.webvm_custom_data) # use base64decode file to execuet the script
}