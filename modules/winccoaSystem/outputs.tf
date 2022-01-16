output "winccoa-master-url" {
  value = "http://${aws_elb.main_elb.dns_name}:80/virt"
}