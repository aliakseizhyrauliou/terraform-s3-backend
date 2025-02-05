variable "ami" {
  type = object({
    most_recent = bool
    filters = list(object({
      name = string
      values = list(string)
    }))
    owners = list(string)
  })
}


variable "instance" {
  type = object({
    instance_type = string
    subnet_id = string
    associate_public_ip_address = bool
  })
}


variable "user_data" {
  type = string
  default = <<-EOF
    #!/bin/bash
    
    sudo apt update

    sudo apt install nginx -y

    sudo mkdir -p /var/www/site

    echo "<html><body><h1>Welcome to Site!</h1></body></html>" | sudo tee /var/www/site/index.html

    sudo tee /etc/nginx/sites-available/default <<EOL
    server {
        listen 80;
        server_name _;

        location /site {
            alias /var/www/site;
            index index.html;
        }
    }
    EOL

    sudo nginx -t

    sudo systemctl restart nginx
  EOF
}