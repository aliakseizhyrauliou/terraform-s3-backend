module "network" {
  source = "../modules/network"
  vpc = var.vpc
  env_name = var.env_name
  aws_region = var.aws_region
}

module "ec2" {
  source = "../modules/ec2"
  ami = var.ec2_configuration.ami
  instance = merge(var.ec2_configuration.instance, {
    subnet_id = module.network.public_subnet_id
  })
}