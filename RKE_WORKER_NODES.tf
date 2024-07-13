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
            sudo -aG docker ubuntu
            sudo -aG root docker
            sudo systemctl reload-daemon
            sudo systemctl reload docker
            sudo reboot
    EOF

  root_block_device {
    volume_size           = "10"
    volume_type           = "gp2"
    delete_on_termination = true
  }

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
            sudo usermod -aG docker ubuntu
            sudo usermod -aG root ubuntu
            sudo systemctl daemon-reload
            sudo systemctl restart docker
            sudo reboot
    EOF

  root_block_device {
    volume_size           = "10"
    volume_type           = "gp2"
    delete_on_termination = true
  }
}


resource "aws_instance" "worker03" {
  ami                         = "ami-0261755bbcb8c4a84"
  availability_zone           = "us-east-1c"
  subnet_id                   = aws_subnet.publicsubnet3.id
  instance_type               = "t3.medium"
  key_name                    = "K8S-KEY"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.SG.id]
  tags = {
    name = "worker03"
  }
  user_data = <<-EOF
        #!/bin/bash
            sudo curl https://get.docker.com | bash
            sudo usermod -aG docker ubuntu
            sudo usermod -aG root ubuntu
            sudo systemctl daemon-reload
            sudo systemctl restart docker
            sudo reboot
    EOF

  root_block_device {
    volume_size           = "10"
    volume_type           = "gp2"
    delete_on_termination = true
  }
}

