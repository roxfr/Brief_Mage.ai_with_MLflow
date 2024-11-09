#!/bin/bash

# PROJECT_NAME=mlops \
#     MAGE_CODE_PATH=/home/src \
#     SMTP_EMAIL=$SMTP_EMAIL \
#     SMTP_PASSWORD=$SMTP_PASSWORD \
#     docker-compose up

export PROJECT_NAME=mlops
export MAGE_CODE_PATH=home/src
export SMTP_EMAIL=$SMTP_EMAIL
export SMTP_PASSWORD=$SMTP_PASSWORD
docker-compose up