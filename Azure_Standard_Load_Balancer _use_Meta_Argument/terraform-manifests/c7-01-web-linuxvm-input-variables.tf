# Linux VM INput Variables Placeholder file

# Web Linux VM Instance Count
variable "web_linuxvm_instnace_count" {
  description = "Web Linux VM Instance Count"
  type = number
  default = 1
}
# Web LB Inbount NAT Port for All VMs
variable "lb_inbound_nat_ports" {
  description = "Web LB Inbound NAT Ports List"
  type = list(string)
  default = [ "1022", "2022","3022","4022","5022" ]
}
