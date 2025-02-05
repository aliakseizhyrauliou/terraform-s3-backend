#General
aws_region="us-east-2"
env_name="dev"

#Network
vpc = {
    vpc_cidr_block="10.0.0.0/16"
    vpc_name="dev"

    public_subnet = {
        public_subnet_cidr_block="10.0.1.0/24"
        public_subnet_map_public_ip_on_launch=true
        public_subnet_availability_zone="us-east-2a"
        public_subnet_name="public-subnet"
    }

    private_subnet = {
        private_subnet_cidr_block="10.0.2.0/24"
        private_subnet_availability_zone="us-east-2a"
        private_subnet_name="private-subnet"
    }

    internet_gateway = {
      name = "internet-gateway" 
    }

    aws_route_table_public_subnet = {
      name = "internet-gateway-public"
    }
}


ec2_configuration = {
    ami = {
        most_recent = true
        filters = [
            {
                name = "name",
                values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
            },
            {
                name = "virtualization-type",
                values = ["hvm"]
            }
        ]
        owners = ["099720109477"]
    }
    instance = {
      instance_type = "t3.micro"
      associate_public_ip_address = true
    }
}