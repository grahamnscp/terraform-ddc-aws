# Terraform create nodes on AWS for Docker EE HA deployment

This repo contains Terraform templates to create new nodes on AWS split across availability zones ready to deploy on using Ansible (or similar automation like salt-ssh etc).

I've used an AMI for Centos 7 based in AWS London, and added a second disk for each node for devicemapper thinpool storage using LVM as the backend storage for the Docker engine.

An S3 bucket is created for the DTR shared storage.  The cluster instances are created with an IAM instance profile which has an IAM role and associated policy to give the storage access required.

### setup.sh

Parses the terraform template files using the variables set in params.sh 


### deploy.sh

Runs terraform apply with some parameter parsing for later config file generation


