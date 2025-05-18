output "private_key_pem" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}

output "instance_public_ip_Nginx-server" {
  value = aws_instance.Nginx-server.public_ip
}

output "instance_public_ip_Apache-server" {
  value = aws_instance.Apache-server.public_ip
}

output "instance_public_ip_Mysql-server" {
  value = aws_instance.Mysql-server.public_ip
}
output "public_key_openssh" {
  value = tls_private_key.ssh_key.public_key_openssh
}

