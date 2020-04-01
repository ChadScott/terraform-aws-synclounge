variable "instance_ami" {
  description = "The AMI to use to launch the Synclounge instance"
  type    = string

  default = ""
}

variable "instance_spot" {
  description = "Use a spot instance instead of an on-demand one"
  type    = bool

  default = true
}

variable "instance_spot_price" {
  description = "The maximum spot price to accept when creating a spot instance"
  type    = string

  default = ""
}

variable "instance_spot_block_duration" {
  description = "The block duration to request for the spot instance"
  type    = number

  default = 0
}

variable "instance_type" {
  description = "The instance type to use launch the Synclounge instance"
  type    = string

  default = "t3.small"
}

variable "private_key_file" {
  description = "Whether to output a private key file for use by ssh"
  type    = bool

  default = false
}

variable "sl_room" {
  description = "The Synclounge room to auto-join"
  type    = string

  default = ""
}

variable "sl_password" {
  description = "The Synclounge room password for auto-join"
  type    = string

  default = ""
}

variable "ssh_whitelist" {
  description = "CIDR blocks to be allowed to access the SSH port of the instance"
  type    = list(string)

  default = []
}

variable "subnet" {
  description = "The subnet to start the instance in"
  type = string
}

variable "web_accessurl" {
  description = "The URL used to reach this Synclounge server"
  type    = string

  default = ""
}
