Project Description:

In this project, I used Ansible as the configuration management tool to provision and manage multiple EC2 servers. I automated the provisioning of these servers—some with Nginx installed, others with Apache2 and MySQL—using GitHub Actions workflows for continuous integration and deployment.

The infrastructure provisioning code is available in my GitHub repository: Ec2-Infra-provisioning-for-ANSIBLE (Public).

After provisioning the servers, I created a separate repository for configuration management using Ansible: Ansible-EC2. This repository contains:

all.yml: A file defining project variables.

inventory/host.ini: An inventory file listing the IP addresses of Nginx servers, Apache2 servers, and MySQL database servers.

.github/: Contains the CI/CD pipeline configuration using GitHub Actions.

playbook/files/: Stores web homepage files for Nginx and Apache servers.

playbook/: Contains the main Ansible playbooks referencing the variables defined in all.yml.

To ensure security, sensitive information is stored as GitHub Actions secrets.
