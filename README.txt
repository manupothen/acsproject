################
Pre-requisites :
################

1. Create S3 bucket in aws to store Terraform state. Name bucket as : 
	*  dev-acsproject

2. Upload 2 images to this dev-acsproject s3 bucket with name "project.jpg" and "project2.jpg"

3. Upload terraform code to Cloud9 Environment.

4. Create SSH key for Dev environment.
	> ssh-keygen -t rsa -f ~/.ssh/Group25-dev

5. Copy SSH key to webserver folder :
	> cp ~/.ssh/Group25-dev.pub ~/environment/project/dev/webservers

#############################
Instructions for deployment :
#############################

1. Change the working directory to dev-network :
	> cd ~/environment/project/dev/network
	> terraform init
	> terraform apply --auto-approve

2. Change the working directory to dev-webservers :
	> cd ~/environment/project/dev/webservers
	> terraform init
	> terraform apply --auto-approve