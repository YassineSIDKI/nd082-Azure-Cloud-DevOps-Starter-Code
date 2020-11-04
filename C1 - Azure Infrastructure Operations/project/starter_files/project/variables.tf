variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  default     = "udacity"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "uksouth"
}

variable "nb_instances" {
  description = "Specify the number of vm instances"
  default     = "3"
}

variable "vm_credentials" {
  description = "the vm credentials should be used as vm admin account "
  type        = map(string)
  default = {
    username = "adminuser"
    password = "P@ssw0rd1234!"
  }
}

variable "vm_size" {
  description = "this allows us to speicfy the size of vm resource"
  default     = "Standard_DS1_v2"
}

variable "packer_image_rg" {
  description = "the resource group name of the packer image from which we will create our VMs"
  default     = "udacity-webserver-rg"
}
