resource "aws_instance" "worker01" {
  ami                         = "ami-0261755bbcb8c4a84"
  instance_type               = "t3.medium"
  key_name                    = "K8S-KEY"
  subnet_id                   = aws_subnet.publicsubnet1.id
  availability_zone           = "us-east-1a"
  vpc_security_group_ids      = [aws_security_group.SG.id]
  associate_public_ip_address = true
  tags = {
    Name = "worker01"
  }
  user_data = <<-EOF
        #!/bin/bash
            sudo curl https://get.docker.com | bash
            curl -sfL https://get.k3s.io | K3S_URL=https://k3s.cbnnow.online:6443 K3S_TOKEN=K1083fd49cda418253c1853e8244b764d6741ba2eb6b3745c66b>
            sudo usermod -aG docker ubuntu
            sudo usermod -aG root ubuntu
            sudo systemctl daemon-reload
            sudo systemctl restart docker
    EOF

}



resource "aws_instance" "worker02" {
  ami                         = "ami-0261755bbcb8c4a84"
  availability_zone           = "us-east-1b"
  subnet_id                   = aws_subnet.publicsubnet2.id
  instance_type               = "t3.medium"
  key_name                    = "K8S-KEY"
  vpc_security_group_ids      = [aws_security_group.SG.id]
  associate_public_ip_address = true
  tags = {
    Name = "worker02"
  }
  user_data = <<-EOF
        #!/bin/bash
            sudo curl https://get.docker.com | bash
            curl -sfL https://get.k3s.io | K3S_URL=https://k3s.cbnnow.online:6443 K3S_TOKEN=K1083fd49cda418253c1853e8244b764d6741ba2eb6b3745c66b66980698f82212f::server:SECRET sh -
            sudo usermod -aG docker ubuntu
            sudo usermod -aG root ubuntu
            sudo systemctl daemon-reload
            sudo systemctl restart docker
    EOF
}
