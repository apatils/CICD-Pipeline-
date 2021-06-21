# DevOps_Test

A complete CICD Pipeline which builds and deploys automatically whenever a code is pushed to this repo.

SETUP Steps:
Pre requisisties: 
* AWS Account 

1) Generate Access and Secret key from AWS 
2) Generate key pair for EC2 instances 
3) Install terraform using package manager (e.g. chocolatey)
4) Add two aws_instance (one for flask web server and another for jenkins) resource with ubuntu AMI and provide the key pair generated in step 2
5) Run command to execture Terraform: 1) terraform init 2) terraform plan 3) terraform apply
6) Verify on aws web -> ec2 -> instances if instance is running 
7) Copy public IP of both instances
8) Install Ansible on WSL (Windows Subsystem for Linux)
9) Open /etc/ansible/hosts file and add the copied I/Ps under [webservers] and [jenkins]
10) Save the file. 
11) Create a new folder called 'Ansible'
12) Write 2 playbooks for each flask webapp and jenkins instances which will install necessary setup required for our job
13) Run both playbooks with 'anisble-playbook file_name.yaml' and wait until the task is finished. 
14) Verify the setup by opening jenkins ec2 instacne on browser with :8080 port 
15) ssh into jenkins ec2 instance to copy the admin password. 
16) Setup jenkins with suggested plugins. 
17) Install ssh plugin manually as we are going to need it for deploying our docker image on flash server ec2 instance. 
18) Create a new webhook on git from settings and add jenkins URL 
19) Select the polling on GIT build option from the build option. 
20) Once any changes are pushed to git repo, jenkins triggers the build automatically and deploys the build on flash web server. 
21) Hit the public ip of flask server with :5050 port and paths (/hello) if you get 200 verification is completed. 
22) To check if CICD is working, edit the app.py and change the return statement and do the push, it should reflect within 5 minutes on the URL. 
