resource "aws_launch_configuration" "winccoaSystem-sub1" {
  image_id = data.aws_ami.amazon-2.image_id
  instance_type = "t3.micro"
  user_data = base64encode(templatefile("${path.module}/winccoa-sub.tpl", { winccoaSysNum="2", winccoaSysName="sub1", winccoaSub1Ip="notused", winccoaSub2Ip="notused" } ))
  security_groups = [aws_security_group.ingress-all-ssh-winccoa.id, aws_security_group.ingress-all-http80.id, aws_security_group.ingress-dist-man.id]
  name_prefix = "${var.winccoaSystemName}-sub1-"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg-winccoaSystem-sub1" {
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
  desired_capacity   = var.desired_instances
  max_size           = var.max_instances
  min_size           = var.min_instances
  name = "${var.winccoaSystemName}-sub1-asg"

  launch_configuration = aws_launch_configuration.winccoaSystem-sub1.name

  health_check_type    = "ELB"
  load_balancers = [
    aws_elb.sub1_elb.id
  ]

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
      instance_warmup = "600"
    }
    triggers = ["tag"]
  }

  tag {
    key                 = "Name"
    value               = "${var.winccoaSystemName}-winccoaSystem-sub1"
    propagate_at_launch = true
  }

}

resource "aws_elb" "sub1_elb" {
  name = "${var.winccoaSystemName}-sub1-elb"
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
  security_groups = [
    aws_security_group.elb_dist.id
  ]

  health_check {
    healthy_threshold = 10
    unhealthy_threshold = 10
    timeout = 60
    interval = 180
    target = "TCP:4777"
  }

  listener {
    lb_port = 4777
    lb_protocol = "tcp"
    instance_port = "4777"
    instance_protocol = "tcp"
  }
}