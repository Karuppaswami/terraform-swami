# Locals Block for custom
locals {
webvm_custom_data = <<CUSTOM_DATA
#!/bin/sh
#sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd  
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo chmod -R 777 /var/www/html 
sudo echo "Welcome to stacksimplify - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/index.html
sudo mkdir /var/www/html/app1
sudo echo "Welcome to stacksimplify - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/app1/hostname.html
sudo echo "Welcome to stacksimplify - WebVM App1 - App Status Page" > /var/www/html/app1/status.html
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to Swami Terraform - WebVM APP-1 </h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app1/index.html
sudo curl -H "Metadata:true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01" -o /var/www/html/app1/metadata.html
CUSTOM_DATA 
}
# Resource : Azure linux Virtual Machine Sale Set 
resource "azurerm_linux_virtual_machine_scale_set" "web_vmss" {
  name= "${local.resource_name_prefix}-web-vmss"
  computer_name_prefix = "web-linux-vm"  # Host Name of the VM
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  sku = "Standard_DS1_v2"
  instances = 2
  admin_username = "adminuser"
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }

  upgrade_mode = "Automatic"

  network_interface {
    name = "web-linux-nsg"
    primary = true
    network_security_group_id = azurerm_network_security_group.web_vmnic_nsg.id
    ip_configuration {
      name = "Internal"
      primary = true
      subnet_id = azurerm_subnet.websubnet.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.web_lb_Backend_address_pool.id  ]
    }
  }

  # custom_data = filebase64("${path.module}/app-scripts/redhat-webvm-script.sh") # we will use either this method or the we will define the script in the file itself.additional_capabilities 
    custom_data = base64decode(locals.webvm_custom_data) # use base64decode file to execuet the script
}
