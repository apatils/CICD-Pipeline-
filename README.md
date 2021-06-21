# DevOps_Test

A complete CICD Pipeline which builds and deploys automatically whenever a code is pushed to this repo.

---
## SETUP STEPS:

Prerequisite: 
- AWS Account 

## Generate AWS Access and Secret Key and Key Pair
- Generate AWS Access and Secret Key by creating a new user under **IAM**, select "Programmatic access". A .csv file will be generated with username, access key and secret key
- Save the .csv file, we will use it in terraform for accessing AWS
- Now from __ec2__ generate a new key-pair ssh which is used by of ec2 for enabling ssh access
---
## Terraform
- Install Terraform directly from their official website or from package manager (e.g. Chocolatey)
- Run command from powershell on windows machine ```choco install terraform```
- Create 4 ```.tf``` files in terraform directory viz. **provider.tf**, **jenkins_instance.tf**, **flask_instance**, **cred.tf** 
  - cred.tf has variables for aws_access_key, aws_secret_key and aws_region
  - provider.tf contains **aws** provider along with region and aws credentials details
  - jenkins_instance.tf has instructions to create a new resource with tag __jenkins-server__ ubuntu AMI and ssh key-pair name which we created above.
  - flask_instance.tf has same instructions as __jenkins_instance__ with tag __flask-server__
- Run following commands sequentially so our ec2 instances gets created
  - ```terraform init```
  - ```terraform plan```
  - ```terraform apply```
- Verify on AWS console if instances are created. 
   
---
## Ansible
- Install ansible on WSL (Windows Subsystem for Linux)
  - ```sudo apt-get update``` 
  - ```sudo apt-add-repository ppa:ansible/ansible``` 
  - ```sudo apt-get install ansible```
- Edit **hosts** file in ```/etc/ansible/``` and add the public IP of both instances under [webservers] and [jenkins] and save the file. 
- Verify if IP is reachable by using command ```ansible ping -m all```
- create 2 playbooks **yamls** one for provisioning jenkins setup and another for python_flask_server.
- Run the playbook one after another with below command <br />
  ```ansible-playbook -e ansible_ssh_private_key_file=/<path_to_.pem_file> jenkins.yaml``` <br />
  ```ansible-playbook -e ansible_ssh_private_key_file=/<path_to_.pem_file> web.yaml``` <br />
- After all tasks are completed successfully, verify running ```sudo docker --version``` on flask-server ec2 instance by ssh into that using ip provided on aws console.

---
## Jenkins
- Verify if jenkins is working by opening **jenkins-server** public IP with postpending ```:8080``` to the URL on web browser
- Copy generated admin password by ssh into jenkins-service to path ```/var/lib/jenkins/secrets/initialAdminPassword```
- Install suggested plugins
- Create a new user
- Install ssh plugin from **Manage Jenkins -> Install Plugins**. This is required as we have to deploy our docker image on flask-service ec2 instance 
- Create a new ssh credential by adding the private key generate by _ssh-pair-key_
- Add the ssh host details in **Manage Jenkins -> Configure System -> SSH Sites** (copy flask-server IP from instance)
- On the Dashboard select __new item__ option, provide a new name for job and click next.
- Add your git project URL under __Source Code Management__
- Under __Build Triggers__ select _GitHub hook trigger for GITScm polling_
- Add _Execute Shell_ step from __Add build step__ dropdown list
- Write code to build, tag and push docker image to docker hub
- Add _Execute shell script on remote host using ssh_ from __Add build step__ dropdown list and select the host we added in **step 7**

## GIT
- For auto jenkins built we need to add a github webhook which will make a __POST__ call to our jenkins job 
- Open __Settings__ tab inside your repo
- Select **Webhooks** option from left pane
- Select add webhook option. Add your jenkins URL under _Payload URL_ select Content-type as _application/json_ and click save.
- Verify if you get ```200 reponse``` 

---
## Test Setup
- Checkout this repo locally and make change in **app.py**'s return string of _/hello_ endpoint to see changes
- Push the code to main branch 
- Wait for few minutes for changes to reflect in below link
- [Check changes reflecting here](http://3.17.139.61:5050/hello) 
 
## Contributor
- Akash Patil <patilakashsuresh@gmail.com>
