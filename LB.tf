# LoadBalancer for control-plane nodes

resource "aws_lb" "test" {
  name               = "RKE-LB"
  load_balancer_type = "network"
  internal           = false
  subnets = [
    aws_subnet.publicsubnet1.id,
    aws_subnet.publicsubnet2.id,
    aws_subnet.publicsubnet3.id
  ]
  enable_deletion_protection = false
}


resource "aws_lb_target_group" "tgtest" {
  name     = "RKE-lbtg"
  port     = 6443
  protocol = "TCP"
  vpc_id   = aws_vpc.k8svpc.id
}

resource "aws_lb_target_group_attachment" "master01" {
  target_group_arn = aws_lb_target_group.tgtest.arn
  target_id        = aws_instance.master1.id
  port             = 6443
}


resource "aws_lb_target_group_attachment" "master02" {
  target_group_arn = aws_lb_target_group.tgtest.arn
  target_id        = aws_instance.master2.id
  port             = 6443
}


resource "aws_lb_target_group_attachment" "master03" {
  target_group_arn = aws_lb_target_group.tgtest.arn
  target_id        = aws_instance.master3.id
  port             = 6443
}


resource "aws_lb_listener" "front_end_http" {
  load_balancer_arn = aws_lb.test.arn
  port              = "6443"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tgtest.arn
  }
}

