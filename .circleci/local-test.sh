#!/bin/bash
set -euxo pipefail

# How to test
# AWS_PROFILE=defalut sh .circleci/local-test.sh
# 

AWS_DEFAULT_REGION=$(aws configure get region)
AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

REPO=circleci-stateless-ssm-parameter

aws ecr describe-repositories --repository-names ${REPO} --region us-east-1 || \
  aws ecr create-repository --repository-name ${REPO} --region us-east-1

ECR=${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ECR}
docker build .circleci -t ${ECR}/${REPO}:latest
docker push ${ECR}/${REPO}:latest

circleci local execute --job simple \
  -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
  -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
  -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
  -e AWS_ACCOUNT_ID=$AWS_ACCOUNT_ID