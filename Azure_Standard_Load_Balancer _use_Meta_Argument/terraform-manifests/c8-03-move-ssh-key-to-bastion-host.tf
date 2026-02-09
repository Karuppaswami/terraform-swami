# Create a Null Resource and Provisioners
resource "null_resource" "null_copy_ssh_key_to_bastion" {
  depends_on = [ azurerm_linux_virtual_machine.bastion_linuxvm.bastion_host_linuxvm ]
  # Connectio0n Block for Provisioners to connect to Azure
  connection {
    type = "ssh"
    host = azurerm_linux_virtual_machine.bastion_linuxvm.public_ip_address
    user = azurerm_linux_virtual_machine.bastion_linuxvm.admin_username
    private_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }
## File Provisioner: Copies the terraform-key.pem file
    provisioner "file" {
      source = "ssh-key/terraform-azure.pem"
      destination = "/tmp/terraform-azure.pem"
      # when = create
      # on_failure = continue
    }
## Remote exec Provisioner: Using remote-exec Provisioner 

    provisioner "remote=exec" {
      inline = [
        "sudo chmod 400 /tmp/terraform-azure.pem"
      ]
    }
}





# Create Time Provisioners - By default they are 
# Destory Time Provisioners - Will be executed during 