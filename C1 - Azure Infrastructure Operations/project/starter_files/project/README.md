# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

## Introduction

In this project, you will create a scalable web server in azure using Packer and Terraform.
You will start by creating a azure image with packer, which will represents a template for your servers, and then create all other resources by terraform.
You will do the majority of tasks via command line.
This project is for learning purposes

## Getting Started

To get started, you will need to:

1. Clone this repository

```
git clone https://github.com/YassineSIDKI/nd082-Azure-Cloud-DevOps-Starter-Code.git
```

2. Install all dependencies (section below) and ensure that all of them are well set

## Dependencies

1. Create an [Azure Account](https://portal.azure.com)
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest).

Then, run this command :

```
az login
```

You should be able to login and see output like this:

```
[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "xxxxxx",
    "id": "xxx",
    "isDefault": true,
    "managedByTenants": [],
    "name": "xxx",
    "state": "Enabled",
    "tenantId": "xxxx",
    "user": {
      "name": "xx@xxx.com",
      "type": "user"
    }
  }
]
```

3. Install [Packer](https://www.packer.io/downloads)

Add packer path to your environment variable and run this command

```
packer -version
```

You should get the packer version in output

4. Install [Terraform](https://www.terraform.io/downloads.html)
   Add terraform path to your environment variable and run this command

```
terraform -version
```

You should get the terraform version in output

## Instructions

1. Create packer image

To create your azure image via packer, you should first set some variables in your environement.
These variables are : `client_id` `subscription_id` `client_secret` and `tenant_id`

To do that you should follow these steps:

- Set an Azure active directory service principale. Here is a good tutorial explaining how to do that: https://www.youtube.com/watch?v=Hg-YsUITnck
- Register an app via "App registrations". You should get a picture like below:
  ![alt text]()

- Go to one of your owned app (which you will use for this project), and copy `client_id` (which is the applicationçid) and `tenant_id`
- Add them to your environment by running this command :

```
export ARM_CLIENT_ID=xxxx
export ARM_TENANT_ID=xxx
```

- In the principal menu, add client secret from 'Certification & secrets'. After doing that you should see something like this :
  ![alt text]()

- add client_secret to your environment by running this command

```
export ARM_CLIENT_SECRET=xxxx
```

- Go to Subscriptions from portal search, get your subscription_id and add it to evironment

```
export ARM_SUBSCRIPTION_ID=xxxx
```

- Add your app as an autorized app for this subscription. Do this from Access controm IAM.
- From Role assignement tab, you should have a view like this
  ![alt text]()

- Add the resource group name that you already created in azure to your environment

```
export ARM_RESOURCE_GROUP=xxxx
```

- Read the server.json first to see if you are ok with image configuration run the packer command

```
packer build server.json
```

### Output

- You should get an output-like:
  ![alt text]()

3. Create resources with terraform

All what you should do, is to update the `variables.tf`

- Change the `packer_image_rg` default value with the good one
- Edit the `location` where you want to create resources
- You are free to edit the other variables at your convenience. You should just keep `nb_instances` var greater than 2 to have a cluster of servers.

The other variables depend on which configuration you want. Here is the details of each one:

#### After changing the variables, you are done (Cool, isn't it !!)

- You can already create all your resources now by running this command

```
terraform init
```

- This will generate folder : . Then run this command :

```
terraform plan --out solution.plan
```

You should see an output like this:
![alt text]()

- If you are ok with that, apply it:

```
terraform apply solution.plan
```

### Output

- You should see a response like this:
  ![alt text]()
  You can check from portal that all resources are created
  ![alt text]()
