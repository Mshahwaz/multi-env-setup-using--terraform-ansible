resource "aws_key_pair" "kp-for-auth" {
    key_name = "${var.env}-key-pair"
    public_key = file("multi-env-key-pair.pub") 
}

# resource "aws_vpc" "default_vpc" {
  
# }

data "aws_vpc" "default_vpc" {
  default = true
}

 data "aws_subnets" "default" {
   filter {
     name = "vpc-id"
     values = [ data.aws_vpc.default_vpc.id ]
   }
 }


resource "aws_security_group" "my-sg" {
  vpc_id = data.aws_vpc.default_vpc.id
  name = "${var.env}-sg"
  description = "Allow user to connect with Ec2"

    ingress {
        description = "Allow traffic on Port 22"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "Allow traffic on Port 80"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "Allow traffic on Port 443"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        description = "allow all traffic to outside"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "SG-for-${var.env}-env"
      Environment = var.env
    }

}


resource "aws_instance" "my-instance" {
count =  var.ins-count
ami = var.ami
instance_type = var.instance_type
subnet_id = data.aws_subnets.default.ids[2]
security_groups = [aws_security_group.my-sg.id]
key_name = aws_key_pair.kp-for-auth.key_name
tags = {
    Name = "${var.env}-server"
    Environment = var.env
}

root_block_device {
  volume_type = var.ebs-v-type
  volume_size = var.ebs-v-size
}
# lifecycle {
#   prevent_destroy = true
# }
}