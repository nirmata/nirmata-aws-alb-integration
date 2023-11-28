resource "aws_lb" "nirmata_alb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  enable_deletion_protection        = false
  enable_http2                      = true
  idle_timeout                      = 60
  enable_cross_zone_load_balancing = true
  subnets            = var.subnets
}

resource "aws_lb_listener" "nirmata_listener" {
  load_balancer_arn = aws_lb.nirmata_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.ssl_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nirmata_target_group.arn
  }
}

resource "aws_lb_target_group" "nirmata_target_group" {
  name        = var.target_group_name
  port        = 31433
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/security/login.html"
    port                = "traffic-port"
    protocol            = "HTTPS"
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
  }
}

resource "aws_lb_listener_rule" "nirmata_rule" {
  listener_arn = aws_lb_listener.nirmata_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nirmata_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/nirmata/*"]
    }
  }
}

data "aws_autoscaling_groups" "eks_nodes" {
  names = var.asg_names
}

resource "aws_autoscaling_attachment" "eks_nodes_attachment" {
  lb_target_group_arn      = aws_lb_target_group.nirmata_target_group.arn
  autoscaling_group_name   = data.aws_autoscaling_groups.eks_nodes.names[0]
}
