output "winccoa-master-url" {
  value = "http://${aws_instance.winccoa-master.public_ip}:80/virt"
}