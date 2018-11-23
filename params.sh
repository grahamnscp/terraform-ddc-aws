#
# These variables are subsituted into templates buy setup.sh
#

# Terraform Variables:
# - variables.tf.template -> variables.tf
#
# note: keep TF_AWS_INSTANCE_PREFIX short as prepends AWS instance names
TF_AWS_INSTANCE_PREFIX=MY
TF_AWS_DOMAINNAME=MY.existing.domain
#
TF_AWS_ROUTE53_ZONE_ID=MY-existingroute53zoneid
#
TF_AWS_REGION=awsregion
TF_AWS_AVAILABILITY_ZONES=availabilityzonea,availabilityzoneb,availabilityzonec
TF_AWS_AVAILABILITY_ZONES_WIN=availabilityzonea,availabilityzoneb,availabilityzonec
# Centos 7: aws --region eu-west-2 ec2 describe-images --owners aws-marketplace --filters Name=product-code,Values=aw0evgkw8e5c1q413zgy5pjce --query 'Images[*].{ Name:Name, ID:ImageId }'
TF_AWS_CENTOS_AMI=ami-00846a67
# WS2K16:   aws --region eu-west-2 ec2 describe-images --owners amazon --filters "Name=name,Values=Windows_Server-2016-English-Core-Base-2018*" --query 'Images[*].{ Name:Name, ID:ImageId }'
TF_AWS_WS2K16_AMI=ami-05f4918ebfd5a1635
#
TF_AWS_DOCKER_VOLUME_SIZE=50
TF_AWS_UCP_MANAGER_COUNT=3
TF_AWS_UCP_WORKER_COUNT=5
TF_AWS_UCP_WINWORK_COUNT=2
#
TF_AWS_MANAGER_INSTANCE_TYPE=t2.large
TF_AWS_WORKER_INSTANCE_TYPE=t2.large
TF_AWS_WINWORK_INSTANCE_TYPE=i3.xlarge
TF_AWS_DTR_INSTANCE_TYPE=t2.large

# Windows instance user_data variables
#
WS2K16_ADMIN_PASSWORD="P@55W0rdH3re!"
WS2K16_SSH_KEY_PUB="ssh-rsa MY-pubsshkeyhere MY-username@example.com"
WS2K16_DOCKER_WIN_URL="https://download.docker.com/components/engine/windows-server/18.09/docker-18.09.0.zip"


# - terraform.tfvars.template -> terraform.tfvars
#
TF_AWS_ACCESS_KEY=MY-awskey
TF_AWS_SECRET_KEY="MY-awssecretkey"
TF_AWS_KEY_NAME=MY-awskeyname


