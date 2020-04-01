resource "aws_security_group" "instance" {
  revoke_rules_on_delete = true
  vpc_id                 = data.aws_subnet.synclounge.vpc_id
}

resource "aws_security_group_rule" "instance_ssh_ingress" {
  type = "ingress"

  security_group_id = aws_security_group.instance.id

  from_port = 22
  to_port   = 22

  protocol = "tcp"

  cidr_blocks = var.ssh_whitelist

  count = length(var.ssh_whitelist) > 0 ? "1" : "0"
}

resource "aws_security_group_rule" "instance_app_ingress" {
  type = "ingress"

  security_group_id = aws_security_group.instance.id

  from_port = 80
  to_port   = 80

  protocol = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "instance_egress" {
  type = "egress"

  security_group_id = aws_security_group.instance.id

  from_port = 0
  to_port   = 0

  protocol = "-1"

  cidr_blocks = ["0.0.0.0/0"]
}
