locals {
  public_ip   = var.instance_spot ? aws_spot_instance_request.synclounge[0].public_ip : aws_instance.synclounge[0].public_ip
  instance_id = var.instance_spot ? aws_spot_instance_request.synclounge[0].id : aws_instance.synclounge[0].id
}

resource "local_file" "private_key" {
  sensitive_content = tls_private_key.synclounge.private_key_pem
  file_permission   = "0600"
  filename          = "synclounge_${var.instance_spot ? aws_spot_instance_request.synclounge[0].public_ip : aws_instance.synclounge[0].public_ip}"

  count = var.private_key_file ? "1" : "0"
}

output "id" {
  description = "A randomly generated UUID to identify this module run from others"
  value = random_uuid.synclounge.result
}

output "public_ip" {
  description = "The public IP of the launched instance"
  value = local.public_ip
}

output "private_key" {
  description = "The unique private key for the launched instance"
  sensitive = true
  value     = tls_private_key.synclounge.private_key_pem
}
