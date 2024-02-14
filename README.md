# zabbix-task

So the first step is to have basic terraform resources which are going to be deployed to our AWS account . 
I'm taking the open source AWS templates from terraform registry . 

Created the basic github actions pipeline which is deploying those resources to the AWS. I know that most of the things there are hard coded , but I don't have time right now to make it as clean and beautiful as possible ;) (I can show you what I did in my current Azure terraform environment - there is no any hard coded variable )

Once we have the things in AWS , we can ssh to the VM and first of all install ansible and run the ansible playbooks there to install zabbix etc.

For sure we will have to adjust SG to open ports for zabbix instance and ansible master/slaves

Create inventory for ansible playbooks and group the VM's ( slaves ) into logical groups on which we have to run the same playbooks

basic steps for ansible :
1) install ansible on master
sudo apt update
sudo apt install ansible
2) Create an Inventory File
/etc/ansible/hosts
[zabbix_server]
server1 ansible_host=10.0.1.63
[zabbix_agent]
server2 ansible_host=10.0.1.64
[zabbix_web_interface]
server3 ansible_host=10.0.1.65 -> we need to make sure that our slave is in the same vpc so we can connect via private IP
3) SSH Configuration - we need to make sure that we can authenticate to our slaves from master ( so also NSG needs to have port 22 open)
4) Test Connection -> ansible all -m ping
5) Write Playbooks
6) Run them -> ansible-playbook <our name>.yml

Based on this simple tutorial : 
https://medium.com/devops-and-sre-learning/zabbix-monitoring-configuration-installation-on-aws-ec2-934c7680dc22

we will have to deploy 4 ec2 instances : 
Master 
Zabbix Server
Zabbix Agent and
Zabbix Web Interface

configure ssh etc. 

then we can run first playbook from our master to the zabbix_server 
ansible-playbook ./ansible/config1.yml

we will have to create such a playbooks for every single server + adjust the configs inside the playbooks for our needs 

It's a simple thing which I created . 

----------------> Things to improve in the future <-------------------

Create our own modules for the resources which we are going to use . 

have the following folder structure : 

root/modules/ec2 
root/modules/vpc etc.

root/providers/zabbix_prod
root/providers/zabbix_test
root/providers/zabbix_dev


Make the variables.auto.tfvars file inside every single providers/x folder and adjust the variables for every single environment . 

Create a pipeline for each environment with the approve step before apply/deploy step
Have outputs after the pipeline finishes it's job with IP of the VM / name and other neccessary variables . 

Create another pipeline which will trigger once the terraform deployment pipeline finish it's job , load the variables from the previous pipeline , connect in this pipeline to the VM , configure this VM + run the ansible playbooks . 
( this would be easier in EKS cluster :) ) 
We can also create preconfigured Images ( AMI ) and inject them into newly created VM ( inject this AMI in terraform code , EC2 module )

