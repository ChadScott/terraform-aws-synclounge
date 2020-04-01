locals {
  vars = {
    sl            = local.sl
    web_accessurl = var.web_accessurl
    path          = path.module
  }

  sl = {
    room     = var.sl_room
    password = var.sl_password
  }
}

resource "tls_private_key" "synclounge" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "synclounge" {
  public_key = tls_private_key.synclounge.public_key_openssh
}

resource "aws_spot_instance_request" "synclounge" {
  block_duration_minutes = var.instance_spot_block_duration
  spot_price             = var.instance_spot_price
  spot_type              = "one-time"
  wait_for_fulfillment   = true

  ami                         = var.instance_ami == "" ? data.aws_ami.synclounge.id : var.instance_ami
  associate_public_ip_address = true
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.synclounge.key_name
  subnet_id                   = var.subnet
  user_data_base64            = base64encode(templatefile("${path.module}/cloud-init/cloud-config.tpl", local.vars))
  vpc_security_group_ids      = [aws_security_group.instance.id]

  root_block_device {
    delete_on_termination = true
  }

  tags = {
    Name = "Synclounge Spot Instance ${random_uuid.synclounge.result}"
  }

  volume_tags = {
    Name = "Synclounge Spot Instance ${random_uuid.synclounge.result}"
  }

  count = var.instance_spot ? "1" : "0"
}

resource "aws_instance" "synclounge" {
  ami                         = var.instance_ami == "" ? data.aws_ami.synclounge.id : var.instance_ami
  associate_public_ip_address = true
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.synclounge.key_name
  subnet_id                   = var.subnet
  user_data_base64            = base64encode(templatefile("${path.module}/cloud-init/cloud-config.tpl", local.vars))
  vpc_security_group_ids      = [aws_security_group.instance.id]

  root_block_device {
    delete_on_termination = true
  }

  tags = {
    Name = "Synclounge Instance ${random_uuid.synclounge.result}"
  }

  volume_tags = {
    Name = "Synclounge Instance ${random_uuid.synclounge.result}"
  }

  count = var.instance_spot ? "0" : "1"
}
