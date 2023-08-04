#!/usr/bin/bash
DIR_NAME=$(dirname "$0")
source $DIR_NAME/auth.sh

az deployment sub create \
    --template-file ./alert-definitions.bicep \
    --name alert-demo \
    --location westeurope \
    --parameter mailAddress=$MAIL_ADDRESS \
    --parameter adminUsername=$ADMIN_USER_NAME \
    --parameter adminPassword=$ADMIN_USER_PASSWORD 
