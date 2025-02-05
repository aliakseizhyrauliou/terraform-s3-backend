data "aws_ami" "ubuntu" {
  most_recent = var.ami.most_recent

  dynamic "filter" {
    for_each = var.ami.filters
    content {
      name   = filter.value.name 
      values = filter.value.values
    }
  }

  owners = var.ami.owners
}


resource "aws_instance" "main" {
  ami              = data.aws_ami.ubuntu.id
  instance_type    = var.instance.instance_type
  subnet_id        = var.instance.subnet_id
  associate_public_ip_address = var.instance.associate_public_ip_address

  user_data = var.user_data
}