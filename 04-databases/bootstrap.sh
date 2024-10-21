#!/bin/bash

component=$1
env_type=$2
# yum install python3.11-devel python3.11-pip -y
# pip3.11 install ansible botocore boto3


# echo "###########################PYTHON#####################################################################"
# curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
# /usr/bin/python3.12 get-pip.py
# /usr/bin/python3.12 -m pip --version
# /usr/bin/python3.12 -m pip install boto3 botocore
# sudo python3 -m pip install boto3 botocore
# sudo yum install python3-pip

# sudo yum install python3-pip -y
# pip3 install boto3 botocore
# python3 -c "import boto3; import botocore; print('boto3 and botocore installed')"

# yum install python3.11-devel python3.11-pip -y
# pip3.11 install ansible botocore boto3
#############################
# # Check if Python 3.11 is already installed
# if ! python3.11 --version &> /dev/null; then
#   echo "Installing Python 3.11..."
#   sudo yum install python3.11-devel python3.11-pip -y
# else
#   echo "Python 3.11 is already installed."
# fi

# # Check if pip3.11 is installed and working
# if ! pip3.11 --version &> /dev/null; then
#   echo "pip3.11 not found, installing..."
#   sudo yum install python3.11-pip -y
# else
#   echo "pip3.11 is already installed."
# fi

# # Install Ansible, botocore, and boto3 using pip3.11
# echo "Installing Ansible, botocore, and boto3..."
# pip3.11 install ansible botocore boto3 --quiet
# #############################################
# pip3.11 install --upgrade ansible
# pip3 install --upgrade boto3 botocore
# ansible-galaxy collection install amazon.aws --force

sudo yum install ansible -y
ansible-pull -U https://github.com/devopsncloud/roboshop-ansible-roles-tf.git -e component=$component -e environment=$env_type main-tf.yml

if [ $? -eq 0 ]
then
    echo "Ansible-Pull Successful"
else
    echo "Ansible-Pull failed"
fi

echo "The component is: $component"
echo "The env_type is : $env_type"  
