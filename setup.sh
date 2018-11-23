#!/bin/bash

source ./params.sh

# sed -i has extra param in OSX cf Linux
SEDBAK=""

UNAME_OUT="$(uname -s)"
case "${UNAME_OUT}" in
    Linux*)     MACHINE=Linux;;
    Darwin*)    MACHINE=Mac
                SEDBAK=".bak"
                ;;
    CYGWIN*)    MACHINE=Cygwin;;
    MINGW*)     MACHINE=MinGw;;
    *)          MACHINE="UNKNOWN:${UNAME_OUT}"
esac
echo OS is ${MACHINE}


# Subsitute terraform variables to generate terraform.tfvars
#
echo ">>> Generating Terraform terraform.tfvars file from terraform.tfvars.template.."

cp ./terraform.tfvars.template ./terraform.tfvars

# Subsitiute tokens "##TOKEN_NAME##"
sed -i $SEDBAK "s/##TF_AWS_ACCESS_KEY##/$TF_AWS_ACCESS_KEY/" ./terraform.tfvars
sed -i $SEDBAK "s/##TF_AWS_SECRET_KEY##/$TF_AWS_SECRET_KEY/" ./terraform.tfvars
sed -i $SEDBAK "s/##TF_AWS_KEY_NAME##/$TF_AWS_KEY_NAME/" ./terraform.tfvars


# Subsitute terraform variables to generate variables.tf
#
echo ">>> Generating Terraform variables.tf file from variables.template.."

cp ./variables.tf.template ./variables.tf

# Subsitiute tokens "##TOKEN_NAME##"
sed -i $SEDBAK "s/##TF_AWS_INSTANCE_PREFIX##/$TF_AWS_INSTANCE_PREFIX/" ./variables.tf
sed -i $SEDBAK "s/##TF_AWS_DOMAINNAME##/$TF_AWS_DOMAINNAME/" ./variables.tf
sed -i $SEDBAK "s/##TF_AWS_ROUTE53_ZONE_ID##/$TF_AWS_ROUTE53_ZONE_ID/" ./variables.tf
sed -i $SEDBAK "s/##TF_AWS_REGION##/$TF_AWS_REGION/" ./variables.tf
sed -i $SEDBAK "s/##TF_AWS_AVAILABILITY_ZONES##/$TF_AWS_AVAILABILITY_ZONES/" ./variables.tf
sed -i $SEDBAK "s/##TF_AWS_AVAILABILITY_ZONES_WIN##/$TF_AWS_AVAILABILITY_ZONE_WINS/" ./variables.tf
sed -i $SEDBAK "s/##TF_AWS_CENTOS_AMI##/$TF_AWS_CENTOS_AMI/" ./variables.tf
sed -i $SEDBAK "s/##TF_AWS_WS2K16_AMI##/$TF_AWS_WS2K16_AMI/" ./variables.tf
sed -i $SEDBAK "s/##TF_AWS_DOCKER_VOLUME_SIZE##/$TF_AWS_DOCKER_VOLUME_SIZE/" ./variables.tf
sed -i $SEDBAK "s/##TF_AWS_UCP_MANAGER_COUNT##/$TF_AWS_UCP_MANAGER_COUNT/" ./variables.tf
sed -i $SEDBAK "s/##TF_AWS_UCP_WORKER_COUNT##/$TF_AWS_UCP_WORKER_COUNT/" ./variables.tf
sed -i $SEDBAK "s/##TF_AWS_UCP_WINWORK_COUNT##/$TF_AWS_UCP_WINWORK_COUNT/" ./variables.tf
sed -i $SEDBAK "s/##TF_AWS_MANAGER_INSTANCE_TYPE##/$TF_AWS_MANAGER_INSTANCE_TYPE/" ./variables.tf
sed -i $SEDBAK "s/##TF_AWS_WORKER_INSTANCE_TYPE##/$TF_AWS_WORKER_INSTANCE_TYPE/" ./variables.tf
sed -i $SEDBAK "s/##TF_AWS_WINWORK_INSTANCE_TYPE##/$TF_AWS_WINWORK_INSTANCE_TYPE/" ./variables.tf
sed -i $SEDBAK "s/##TF_AWS_DTR_INSTANCE_TYPE##/$TF_AWS_DTR_INSTANCE_TYPE/" ./variables.tf
sed -i $SEDBAK "s/##WS2K16_ADMIN_PASSWORD##/$WS2K16_ADMIN_PASSWORD/" ./variables.tf
# Catch forward slashes
WS2K16_SSH_KEY_PUB_=`echo $WS2K16_SSH_KEY_PUB | sed 's~/~\\\/~g'`
sed -i $SEDBAK "s/##WS2K16_SSH_KEY_PUB##/$WS2K16_SSH_KEY_PUB_/" ./variables.tf
WS2K16_DOCKER_WIN_URL_=`echo $WS2K16_DOCKER_WIN_URL | sed 's~/~\\\/~g'`
sed -i $SEDBAK "s/##WS2K16_DOCKER_WIN_URL##/$WS2K16_DOCKER_WIN_URL_/" ./variables.tf

exit 0

