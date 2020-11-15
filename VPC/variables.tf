variable "inbound_ports" {
  type = map(number)
  default = {
    80 = 80,
    22 = 22,
    8080 = 8080,
    3306 = 3306
  }  
}
