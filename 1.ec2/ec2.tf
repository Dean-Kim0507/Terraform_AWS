provider "aws" {
  region = "ca-central-1"
}

# variable block for vpc id
variable "vpc_id" {
  default = "vpc-e288bc8a"
}

# variable block for subnet id
variable "subnet_id" {
  default = ["subnet-ae4366c6", "subnet-42fc8a38"]
}

# current ami id
data "aws_ami" "amzn2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.????????.?-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Canonical
}

  # security group
resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow web inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
      description      = "web from VPC"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  

  egress {
      description      = "web from VPC"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  

  tags = {
    Name = "allow_web"
  }
}

# aws instance
resource "aws_instance" "web-1b" {
  ami           = data.aws_ami.amzn2.id
  instance_type = "t2.micro"
  # keypair 
  key_name = "tf-keypair"
  # security
  vpc_security_group_ids = [aws_security_group.allow_web.id]
  # availability zone
  availability_zone = "ca-central-1b"
  # subnet
  subnet_id = var.subnet_id[1]
  # 
  user_data = file("./init-script.sh")
  # ec2 volume size
  root_block_device  {
    volume_size = 30
  }

  # name
  tags = {
    Name = "web-1b"
  }
}

# aws instance
resource "aws_instance" "web-1a" {
  ami           = data.aws_ami.amzn2.id
  instance_type = "t2.micro"
  # keypair 
  key_name = "tf-keypair"
  # security
  vpc_security_group_ids = [aws_security_group.allow_web.id]
  # availability zone
  availability_zone = "ca-central-1a"
  # subnet
  subnet_id = var.subnet_id[0]
  # 
  user_data = file("./init-script.sh")
  # ec2 volume size
  root_block_device  {
    volume_size = 30
  }

  # name
  tags = {
    Name = "web-1a"
  }
}

# Get latest ami id
# aws ec2 describe-images \
# --owners self amazon \
# --filters "Name=name,Values=amzn2-ami-hvm-2.0.????????.?-x86_64-gp2" "Name=state,Values=available" \
# --query "reverse(sort_by(Images, &CreationDate))[:1].ImageId" \
# --output text

## AMI created date and id 

# aws ec2 describe-images --owners amazon \
# --filter "Name=name,Values=amzn2-ami-hvm-2.0.????????.?-x86_64-gp2" "Name=state,Values=available" \
# --output text \
# grep IMAGES \
# awk '{print $3, $14}' \
# sort

