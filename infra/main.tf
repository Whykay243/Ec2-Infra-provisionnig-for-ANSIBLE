provider "aws" {
  region = var.region
}

data "aws_vpc" "default" {
  default = true
}


resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-allow-web-and-ssh"
  description = "Allow SSH, HTTP, HTTPS, and app ports"
  vpc_id      = data.aws_vpc.default.id

  # Inbound Rules
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ingress rule for Application on Port 8080
ingress {
  description = "App Port 8080"
  from_port   = 8080
  to_port     = 8080
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"] # Open to the public internet
  # Port 8080 is commonly used for web applications and HTTP servers
}

# Ingress rule for Monitoring or Secondary App on Port 9090
ingress {
  description = "App Port 9090"
  from_port   = 9090
  to_port     = 9090
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  # Port 9090 is often used by Prometheus or secondary app services
}

# Ingress rule for MySQL Database
ingress {
  description = "DB Port 3306"
  from_port   = 3306
  to_port     = 3306
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  # Port 3306 is the default port for MySQL databases
}

# Ingress rule for Kubernetes API Server
ingress {
  description = "Kube API Server"
  from_port   = 6443
  to_port     = 6443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  # Port 6443 is used by kubectl and internal components to access the API server
}

# Ingress rule for etcd (Kubernetes backing store)
ingress {
  description = "Kube Etcd"
  from_port   = 2379
  to_port     = 2380
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  # Ports 2379–2380 are used by etcd for cluster communication and client access
}

# Ingress rule for Kubelet communication
ingress {
  description = "Kubelet"
  from_port   = 10250
  to_port     = 10250
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  # Port 10250 is used for communication between the API server and Kubelets
}

# Ingress rule for Kubernetes Controller Manager
ingress {
  description = "Kube Controller Manager"
  from_port   = 10257
  to_port     = 10257
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  # Port 10257 is used by the controller manager service in Kubernetes
}

# Ingress rule for Kubernetes Scheduler
ingress {
  description = "Kube Scheduler"
  from_port   = 10259
  to_port     = 10259
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  # Port 10259 is used by the Kubernetes scheduler service
}

# Ingress rule for NodePort services
ingress {
  description = "NodePort Services"
  from_port   = 30000
  to_port     = 32767
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  # Port range 30000–32767 is used by Kubernetes to expose services externally via NodePort
}

# Outbound Rules - Allow all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kubernetes-workers-nodes"
  }
}

resource "aws_instance" "master" {
  ami           = "ami-084568db4383264d4"
  instance_type = var.instance1
  key_name      = aws_key_pair.generated_key.key_name
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "Master-Node"
  }
}
resource "aws_instance" "worker-node-1" {
  ami           = "ami-084568db4383264d4"
  instance_type = var.instance2
  key_name      = aws_key_pair.generated_key.key_name
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "Worker-Node-1"
  }
}

resource "aws_instance" "worker-node-2" {
  ami           = "ami-084568db4383264d4"
  instance_type = var.instance2
  key_name      = aws_key_pair.generated_key.key_name
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "Worker-Node-2"
  }
}
