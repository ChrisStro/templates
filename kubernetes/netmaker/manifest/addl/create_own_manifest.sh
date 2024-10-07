#!/bin/bash
echo 'This script create a single file for your deployment'
read -p "Enter your basedomain for netmaker: " MY_NETMAKER_BASE_DOMAIN
read -p "Enter your netmaker master key for netmaker: " MY_MASTER_KEY
read -p "Enter your mq username: " MY_MQ_USERNAME
read -p "Enter your mq password: " MY_MQ_PASSWORD
read -p "Enter hostname of your kubernetes-node: " MY_KUBEHOSTNAME

cat ../*.yml |
    sed "s/NETMAKER_BASE_DOMAIN/$MY_NETMAKER_BASE_DOMAIN/g" |
    sed "s/REPLACE_MASTER_KEY/$MY_MASTER_KEY/g" |
    sed "s/REPLACE_MQ_USERNAME/$MY_MQ_USERNAME/g" |
    sed "s/REPLACE_MQ_PASSWORD/$MY_MQ_PASSWORD/g" |
    sed "s/REPLACE_KUBEHOSTNAME/$MY_KUBEHOSTNAME/g" |
    tee MY_OWN_NETMAKER_DEPLOYMENT.yml