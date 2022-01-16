resource "aws_launch_configuration" "winccoaSystem-master" {
  image_id = data.aws_ami.amazon-2.image_id
  instance_type = "t3.micro"
  user_data = base64encode(templatefile("${path.module}/winccoa-master.tpl", { winccoaSysNum="1", winccoaSysName="master${var.winccoaSystemIdx}", winccoaSub1Ip=aws_instance.winccoa-sub1.public_ip, winccoaSub2Ip=aws_instance.winccoa-sub2.public_ip } ))
  security_groups = [aws_security_group.ingress-all-ssh-winccoa.id, aws_security_group.ingress-all-http80.id, aws_security_group.ingress-dist-man.id]
  name_prefix = "${var.winccoaSystemName}-main-"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg-winccoaSystem-master" {
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
  desired_capacity   = var.desired_instances
  max_size           = var.max_instances
  min_size           = var.min_instances
  name = "${var.winccoaSystemName}-master-asg"

  launch_configuration = aws_launch_configuration.winccoaSystem-master.name

  health_check_type    = "ELB"
  load_balancers = [
    aws_elb.main_elb.id
  ]

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
      instance_warmup = "60"
    }
    triggers = ["tag"]
  }

  tag {
    key                 = "Name"
    value               = "${var.winccoaSystemName}-winccoaSystem-master"
    propagate_at_launch = true
  }

}

resource "aws_elb" "main_elb" {
  name = "${var.winccoaSystemName}-master-elb"
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
  security_groups = [
    aws_security_group.elb_http.id
  ]

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:80/"
  }

  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "80"
    instance_protocol = "http"
  }
}