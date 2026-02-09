# Locals Block for custom data
locals {
bastion_host_custom_data = <<CUSTOM_DATA
#!/bin/sh
#sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd  
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo yum install -y telnet
sudo chmod -R 777 /var/www/html 
sudo echo "Welcome to Swami Terraform - Bastion Host - VM Hostname: $(hostname)" > /var/www/html/index.html
CUSTOM_DATA  
}


# Create Bastion Public IP 
resource "azurerm_public_ip" "bastion_host_publicip" {
  name = "${local.resource_name_prefix}-bastion_host_publicip"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  allocation_method = "Static"
  sku = "Standard"
}
# Create Network Security Group
resource "azruerm_network_interface" "bastion_linuxvm_nic" {
  name = "${local.resource_name_prefix}-bastion_linuxvm_nic"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location

  ip_configuration {
    name = "bastion-linuxvm-ip-1"
    subnet_id = azurerm_subnet_bastionsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.bastion_host_publicip.id
    primary = true
  }
}

# Resource : Azure Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "bastion_linuxvm" {
  name= "${local.resource_name_prefix}-bastion-linuxvm"
  computer_name = "bastion-linux-vm"  # Host Name of the VM
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  size = "Standard_DS1_v2"
  admin_username = "adminuser"
  network_interface_ids = [azurerm_network_interface.bastion_linuxvm_nic.id]
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

    custom_data = base64decode(local.bastion_host_custom_data)
  # custom_data = filebase64("${path.module}/app-scripts/redhat-webvm-script.sh") # we will use either this method or the we will define the script in the file itself.additional_capabilities 
  # custom_data = base64decode(locals.webvm_custom_data) # use base64decode file to execuet the script
}