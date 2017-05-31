# terraform-ddc-create-nodes
Terraform to create DDC nodes

This repo contains Terraform templates to create new nodes on AWS split across availability zones ready to deploy on using Ansible (or similar automation like salt-ssh etc).

I've used an AMI for Centos 7 based in AWS London, and added a second disk for each node for devicemapper thinpool storage using LVM as the backend storage for the Docker engine.

Please note that the DTR deployment is currently WIP as I want to add S3 shared storage for the cluster to work.

