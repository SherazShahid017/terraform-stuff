variable "inbound_ports" {
  type = map(number)
  default = {
    80 = 80,
    22 = 22,
    8080 = 8080  
  }  
}