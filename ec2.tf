resource "aws_instance" "my_ec2" {
  ami           = "ami-0ebfd941bbafe70c6" 
  instance_type = "t2.micro"    

  tags = {
    Name = "MyEC2Instance-1"
  }
 
}
