#tf init - plugin download
#tf plan - code 검토
#tf apply - 검토 문제없으니 심사 meta argument -> aws key pair로 전송
# Configure the AWS Provider
provider "aws" {
  region = "ca-central-1"
}
#aws key pair
resource "aws_key_pair" "tf-keypair" {
  key_name   = "tf-keypair"
  # public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDVkJDZoFBIZNQZYlekkBWlOOiBdj2g3L5AHoP2V+465l556vuUS9DBETQA3CPu2eZQA7iUkB30vfHrRtajCtXMjr1KEupbj+XmOYx80IBq075x1DsuI3WgZXze8XyvUQjdZTEF50HfR9nkxivaCbzoMQNmadwHDsj9uuCN8peQmsGtOMr13hQstKtqiGNzZFNvjhEfGTcF7B0+FgNRBASjx09SF/J+SPttCFglSKB1Y/34wAE+sm25PgArH3ZkO3xvrd+gMKxsZjzta1F1TtgPGo+jhpPfo+JYpfWnEhzB0L3D7nVTJbQL6lc4lVigbJah+2u1UEjmO9/z9QGurQGSRf9ESWN/+9depzAjlFKdioBE2ko1rSFUrbAnaxc1h7rd2SYK5/OcSeICE2jQJjtNJN3Z+MkKH5sRPzfOZyQBeznuAbVGSy3JzA8wyUVTmkrQFSyuLD0NILkutOqQjmdAn+0A6tOfPj+t8BaifaeqynSuncyvTBeotZTETZg3g9Pg2/RtnXIOu0jnHvZ2wqaHfhykUWX+t9LQz4AJD4fJXZ4e2Br56adWy6+Cv7nBJc5XQKRTPDs+6E43IEN5U5rMjbdgeIEBI75qinF9N0S3LkYONzWbvgk7J1Z/wSWVzftXN0bJnDCheZ4EvVQlP69cjsaxarlQR8oIXJ52u+N8WQ=="
  public_key = file("/home/ec2-user/.ssh/tf-keypair.pub")
  
}