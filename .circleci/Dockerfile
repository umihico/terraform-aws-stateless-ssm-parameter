FROM --platform=linux/amd64 amazonlinux:2
RUN yum update -y && \
  yum groupinstall "Development tools" -y && \
  yum install -y yum-utils
RUN yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo && \
  yum -y install terraform
RUN curl -OL https://github.com/gruntwork-io/terragrunt/releases/download/v0.36.0/terragrunt_linux_amd64 && \
  mv terragrunt_linux_amd64 /usr/local/bin/terragrunt && \
  chmod +x /usr/local/bin/terragrunt
RUN yum install python3 -y && \
  pip3 install awscli