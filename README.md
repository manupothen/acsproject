# project

# ACS730 final project: Group 25

# Group members: Manu Pothen, Rosemary Sebastian, Bibin Mekkattukunnil Biju


################
Pre-requisites :
################

1. Create three S3 buckets in AWS to store Terraform state. Name bucket as : 
	*  dev-acsproject-group25
	*  staging-acsproject-group25
	*  prod-acsproject-group25

2. Upload 2 images "project.jpg" and "project2.jpg" to all three s3 buckets.

3. Git pull terraform code to Cloud9 environment.

4. Create three SSH keys for Dev, Staging and Prod environments.
	> ssh-keygen -t rsa -f ~/.ssh/Group25-dev
	> ssh-keygen -t rsa -f ~/.ssh/Group25-staging
	> ssh-keygen -t rsa -f ~/.ssh/Group25-prod

5. Copy SSH keys to webserver folder :
	> cp ~/.ssh/Group25-dev.pub ~/environment/project/env/dev/webservers
	> cp ~/.ssh/Group25-staging.pub ~/environment/project/env/staging/webservers
	> cp ~/.ssh/Group25-prod.pub ~/environment/project/env/prod/webservers

#############################
Instructions for deployment :
#############################

1. Change the working directory to dev-network :
	> cd ~/environment/project/env/dev/network
	> terraform init
	> terraform apply --auto-approve

2. Change the working directory to dev-webservers :
	> cd ~/environment/project/env/dev/webservers
	> terraform init
	> terraform apply --auto-approve

3. Change the working directory to staging-network :
	> cd ~/environment/project/env/staging/network
	> terraform init
	> terraform apply --auto-approve

4. Change the working directory to staging-webservers :
	> cd ~/environment/project/env/staging/webservers
	> terraform init
	> terraform apply --auto-approve

5. Change the working directory to prod-network :
	> cd ~/environment/project/env/prod/network
	> terraform init
	> terraform apply --auto-approve

6. Change the working directory to prod-webservers :
	> cd ~/environment/project/env/prod/webservers
	> terraform init
	> terraform apply --auto-approve
