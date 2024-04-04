# Introduction 
This is terraform code, with which you can create automated Infra Cluster for your application Environment. This terraform code is modularaized. 

# Getting Started
Copy this GitHub code into you local or in Azure DevOps Repo by importing and create a build pipeline 
1.	Go to Azure DevOps Repo and create a new one by import my github Repo (no authentication is needed as this is public Repo)
2.	Set up Build Pipeline with Azure Subscription and Storage Account and Container Details ( these are requried to store the Remote Backend of terraform State file)
3.	Add Terraform Init, Plan, Apply with the help of Task Assistant 
4.	Run the Build Pipeline

# Prerequisite
1. One Azure Cloud Account with a valid Subscription
2. Azure Resoruce Group
3. Storage Account with one Container

# Contribute
TODO: Explain how other users and developers can contribute to make your code better. 

# Reference
Please follow and checkout my blog for more details 
I have explained here how to deploy in detailed. 
