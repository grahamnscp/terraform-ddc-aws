#!/bin/bash

TMP_FILE=/tmp/terraform-output.tmp.$$

source ./params.sh


# Run the terraform deployment..
#
echo ">>> Running Terraform apply.."


# Run the Terraform apply
echo
terraform apply
echo ">>> done."


# Collect output variables
echo
echo ">>> Collecting variables from terraform output.."
terraform output > $TMP_FILE


# Some parsing into shell variables and arrays
echo ">>> Parsing Terraform variables.."
DATA=`cat $TMP_FILE |sed "s/'//g"|sed 's/\ =\ /=/g'`
DATA2=`echo $DATA |sed 's/\ *\[/\[/g'|sed 's/\[\ */\[/g'|sed 's/\ *\]/\]/g'|sed 's/\,\ */\,/g'`

for var in `echo $DATA2`
do
  var_name=`echo $var | awk -F"=" '{print $1}'`
  var_value=`echo $var | awk -F"=" '{print $2}'|sed 's/\]//g'|sed 's/\[//g'`

  case $var_name in
    "region")
      REGION="$var_value"
      ;;
    "domain_name")
      DOMAIN_NAME="$var_value"
      ;;

    "dtr_s3_id")
      DTR_S3_ID="$var_value"
      ;;
    "dtr_s3_arn")
      DTR_S3_ARN="$var_value"
      ;;

    "route53-ucp")
      UCP_LB_FQDN="$var_value"
      ;;
    "route53-dtr")
      DTR_LB_FQDN="$var_value"
      ;;

    # Managers:
    "ucp-manager-primary-public-name")
      UCP_MANAGER_PRIMARY_PUBLIC_NAME=$var_value
      ;;
    "ucp-manager-primary-public-ip")
      UCP_MANAGER_PRIMARY_PUBLIC_IP=$var_value
      ;;
    "route53-ucp-managers")
      UCP_MANAGERS=$var_value
      COUNT=0
      for entry in $(echo $var_value |sed "s/,/ /g")
      do
        COUNT=$(($COUNT+1))
        MANAGER_NAME[$COUNT]=$entry
      done
      NUM_MANAGERS=$COUNT
      ;;
    "ucp-managers-public-names")
      UCP_MANAGERS_PUBLIC_NAMES="$var_value"
      COUNT=0
      for entry in $(echo $var_value |sed "s/,/ /g")
      do
        COUNT=$(($COUNT+1))
        MANAGER_PUBLIC_NAME[$COUNT]=$entry
      done
      ;;
    "ucp-managers-public-ips")
      UCP_MANAGERS_PUBLIC_IPS="$var_value"
      COUNT=0
      for entry in $(echo $var_value |sed "s/,/ /g")
      do
        COUNT=$(($COUNT+1))
        MANAGER_PUBLIC_IP[$COUNT]=$entry
      done
      ;;

    # workers:
    "route53-ucp-workers")
      UCP_WORKERS="$var_value"
      COUNT=0
      for entry in $(echo $var_value |sed "s/,/ /g")
      do
        COUNT=$(($COUNT+1))
        WORKER_NAME[$COUNT]=$entry
      done
      NUM_WORKERS=$COUNT
      ;;
    "ucp-workers-public-names")
      UCP_WORKERS_PUBLIC_NAMES="$var_value"
      COUNT=0
      for entry in $(echo $var_value |sed "s/,/ /g")
      do
        COUNT=$(($COUNT+1))
        WORKER_PUBLIC_NAME[$COUNT]=$entry
      done
      ;;
    "ucp-workers-public-ips")
      UCP_WORKERS_PUBLIC_IPS="$var_value"
      COUNT=0
      for entry in $(echo $var_value |sed "s/,/ /g")
      do
        COUNT=$(($COUNT+1))
        WORKER_PUBLIC_IP[$COUNT]=$entry
      done
      ;;
    "route53-ucp-winworks")
      UCP_WINWORK="$var_value"
      COUNT=0
      for entry in $(echo $var_value |sed "s/,/ /g")
      do
        COUNT=$(($COUNT+1))
        WINWORK_NAME[$COUNT]=$entry
      done
      NUM_WINWORK=$COUNT
      ;;
    "ucp-winwork-public-names")
      UCP_WINWORK_PUBLIC_NAMES="$var_value"
      COUNT=0
      for entry in $(echo $var_value |sed "s/,/ /g")
      do
        COUNT=$(($COUNT+1))
        WORKER_PUBLIC_NAME[$COUNT]=$entry
      done
      ;;
    "ucp-winwork-public-ips")
      UCP_WINWORK_PUBLIC_IPS="$var_value"
      COUNT=0
      for entry in $(echo $var_value |sed "s/,/ /g")
      do
        COUNT=$(($COUNT+1))
        WINWORK_PUBLIC_IP[$COUNT]=$entry
      done
      ;;

    # DTRs:
    "route53-ucp-dtrs")
      UCP_DTRS="$var_value"
      COUNT=0
      for entry in $(echo $var_value |sed "s/,/ /g")
      do
        COUNT=$(($COUNT+1))
        DTR_NAME[$COUNT]=$entry
      done
      NUM_DTRS=$COUNT
      ;;
    "dtrs-public-names")
      DTRS_PUBLIC_NAMES="$var_value"
      COUNT=0
      for entry in $(echo $var_value |sed "s/,/ /g")
      do
        COUNT=$(($COUNT+1))
        DTR_PUBLIC_NAME[$COUNT]=$entry
      done
      ;;
    "dtrs-public-ips")
      DTRS_PUBLIC_IPS="$var_value"
      COUNT=0
      for entry in $(echo $var_value |sed "s/,/ /g")
      do
        COUNT=$(($COUNT+1))
        DTR_PUBLIC_IP[$COUNT]=$entry
      done
      ;;
  esac
done

echo ">>> done."


# Output shell variables
echo
echo ">>> Variables from Terraform deployment are:"
echo REGION=$REGION
echo DOMAIN_NAME=$DOMAIN_NAME
echo UCP_LB_FQDN=$UCP_LB_FQDN
echo DTR_LB_FQDN=$DTR_LB_FQDN

echo UCP_MANAGER_PRIMARY_PUBLIC_NAME=$UCP_MANAGER_PRIMARY_PUBLIC_NAME
echo UCP_MANAGER_PRIMARY_PUBLIC_IP=$UCP_MANAGER_PRIMARY_PUBLIC_IP

echo NUM_MANAGERS=$NUM_MANAGERS
for (( COUNT=1; COUNT<=$NUM_MANAGERS; COUNT++ ))
do
  echo MANAGER_NAME[$COUNT]=${MANAGER_NAME[$COUNT]}
  echo MANAGER_PUBLIC_NAME[$COUNT]=${MANAGER_PUBLIC_NAME[$COUNT]}
  echo MANAGER_PUBLIC_IP[$COUNT]=${MANAGER_PUBLIC_IP[$COUNT]}
done

echo NUM_WORKERS=$NUM_WORKERS
for (( COUNT=1; COUNT<=$NUM_WORKERS; COUNT++ ))
do
  echo WORKER_NAME[$COUNT]=${WORKER_NAME[$COUNT]}
  echo WORKER_PUBLIC_NAME[$COUNT]=${WORKER_PUBLIC_NAME[$COUNT]}
  echo WORKER_PUBLIC_IP[$COUNT]=${WORKER_PUBLIC_IP[$COUNT]}
done

echo NUM_WINWORK=$TF_AWS_UCP_WINWORK_COUNT
for (( COUNT=1; COUNT<=$TF_AWS_UCP_WINWORK_COUNT; COUNT++ ))
do
  echo WINWORK_NAME[$COUNT]=${WINWORK_NAME[$COUNT]}
  echo WINWORK_PUBLIC_NAME[$COUNT]=${WINWORK_PUBLIC_NAME[$COUNT]}
  echo WINWORK_PUBLIC_IP[$COUNT]=${WINWORK_PUBLIC_IP[$COUNT]}
done

echo NUM_DTRS=$NUM_DTRS
for (( COUNT=1; COUNT<=$NUM_DTRS; COUNT++ ))
do
  echo DTR_NAME[$COUNT]=${DTR_NAME[$COUNT]}
  echo DTR_PUBLIC_NAME[$COUNT]=${DTR_PUBLIC_NAME[$COUNT]}
  echo DTR_PUBLIC_IP[$COUNT]=${DTR_PUBLIC_IP[$COUNT]}
done

echo DTR_S3_ID=$DTR_S3_ID
echo DTR_S3_ARN=$DTR_S3_ARN
echo ">>> done."


/bin/rm $TMP_FILE
exit 0

