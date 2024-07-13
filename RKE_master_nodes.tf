# master nodes for RKE cluster
# EOF just happens to be the string you are using totag the beginning and ending of a multiline string
# we can use anything there that doesn't occur in your actual multiline string. you could be replacing
# EOF with MYMULTILINESTRING 

resource "aws_instance" "master1" {
  ami                         = "ami-0261755bbcb8c4a84"
  availability_zone           = "us-east-1a"
  instance_type               = "t3.medium"
  key_name                    = "K8S-KEY"
  subnet_id                   = aws_subnet.publicsubnet1.id
  vpc_security_group_ids      = [aws_security_group.SG.id]
  associate_public_ip_address = true
  tags = {
    Name = "master1"
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



resource "aws_instance" "master2" {
  ami                         = "ami-0261755bbcb8c4a84"
  availability_zone           = "us-east-1b"
  instance_type               = "t3.medium"
  key_name                    = "K8S-KEY"
  subnet_id                   = aws_subnet.publicsubnet2.id
  vpc_security_group_ids      = [aws_security_group.SG.id]
  associate_public_ip_address = true
  tags = {
    Name = "master2"
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


resource "aws_instance" "master3" {
  ami                         = "ami-0261755bbcb8c4a84"
  availability_zone           = "us-east-1c"
  instance_type               = "t3.medium"
  key_name                    = "K8S-KEY"
  subnet_id                   = aws_subnet.publicsubnet3.id
  vpc_security_group_ids      = [aws_security_group.SG.id]
  associate_public_ip_address = true
  tags = {
    Name = "master3"
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


