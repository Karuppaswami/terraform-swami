# Linux VM INput Variables Placeholder file


variable "web_vmss_nsg_inbound_ports" {
  description = "Web VMSS nsg inbound Ports"
  type = list(string)
  default = [22, 80, 443]
}

