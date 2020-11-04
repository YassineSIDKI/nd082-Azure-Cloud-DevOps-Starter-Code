# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

## Introduction

In this project, you will create a scalable web server in azure using Packer and Terraform.
You will start by creating an azure image with packer, which represents a template for your servers, and then create all other resources by terraform.
You will do the majority of tasks via command line.

## Getting Started

Clone this repository

```
git clone https://github.com/YassineSIDKI/nd082-Azure-Cloud-DevOps-Starter-Code.git
```

## Dependencies

1. Create an [Azure Account](https://portal.azure.com)
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest). Then run this command :

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

3. Install [Packer](https://www.packer.io/downloads). Then add packer path to your environment variable and run this command

```
packer -version
```

You should get the packer version as an output

4. Install [Terraform](https://www.terraform.io/downloads.html). Then add terraform path to your environment variable and run this command

```
terraform -version
```

You should get the terraform version as an output

## Instructions

### Create an image with packer

To create your azure image via packer, you should first set some variables in your environement.
These variables are : `client_id` `subscription_id` `client_secret` and `tenant_id`

To do that you should follow these steps:

- Set an Azure active directory service principale. Here is a good tutorial explaining how to do that: https://www.youtube.com/watch?v=Hg-YsUITnck
- Register an app via "App registrations". You should get a picture like below:
  ![alt text](https://raw.githubusercontent.com/YassineSIDKI/nd082-Azure-Cloud-DevOps-Starter-Code/master/C1%20-%20Azure%20Infrastructure%20Operations/project/starter_files/project/appRegistration.png)

- Go to one of your owned app (which you will use for this project), and copy `client_id` (that corresponds to the application_id) and `tenant_id`
- Add them to your environment variables by running this command :

```
export ARM_CLIENT_ID=xxxx
export ARM_TENANT_ID=xxx
```

- In the principal menu, add client secret from **Certification & secrets**. You should see something like this :
  ![alt text](https://github.com/YassineSIDKI/nd082-Azure-Cloud-DevOps-Starter-Code/blob/master/C1%20-%20Azure%20Infrastructure%20Operations/project/starter_files/project/clientSecret.png?raw=true)

- Add client_secret to your environment variables by running this command

```
export ARM_CLIENT_SECRET=xxxx
```

- Go to Subscriptions from portal search, get your `subscription_id` and add it to evironment

```
export ARM_SUBSCRIPTION_ID=xxxx
```

- Add your app as an authorized app for this subscription. Do this from **Access control IAM**
- From Role assignement tab, you should have a view like this
  ![alt text](https://github.com/YassineSIDKI/nd082-Azure-Cloud-DevOps-Starter-Code/blob/master/C1%20-%20Azure%20Infrastructure%20Operations/project/starter_files/project/IAMpacker.png?raw=true)

- Add the resource group name that you already created in azure and on which you want to create your resource, to your environment variables:

```
export ARM_RESOURCE_GROUP=xxxx
```

- Read the server.json first to see if you are ok with image configuration, then run the packer command

```
packer build server.json
```

### Output

You should get as an output a response like this :
![alt text](https://github.com/YassineSIDKI/nd082-Azure-Cloud-DevOps-Starter-Code/blob/master/C1%20-%20Azure%20Infrastructure%20Operations/project/starter_files/project/IAMpacker.png?raw=true)

### Create resources with terraform

All what you should do, is to update the `variables.tf`

- Change the `packer_image_rg` default value with the good one
- Edit the `location` where you want to create resources. It should be the same location where the resource group is created
- You are free to edit the other variables at your convenience. You should just keep `nb_instances` variable greater than 2 to have a cluster of servers.

- You can already create all your resources now by running this command

```
terraform init
```

- This will generate terraform plugin folder and tfstate file Then run this command :

```
terraform plan --out solution.plan
```

You should see an output like this:
![alt text](https://github.com/YassineSIDKI/nd082-Azure-Cloud-DevOps-Starter-Code/blob/master/C1%20-%20Azure%20Infrastructure%20Operations/project/starter_files/project/IAMpacker.png?raw=true)

- If you are ok with that, apply it:

```
terraform apply solution.plan
```

### Output

- You should see a response like this:
  ![alt text](https://github.com/YassineSIDKI/nd082-Azure-Cloud-DevOps-Starter-Code/blob/master/C1%20-%20Azure%20Infrastructure%20Operations/project/starter_files/project/IAMpacker.png?raw=true)

  You can check from portal that all resources are created
  ![alt text](https://github.com/YassineSIDKI/nd082-Azure-Cloud-DevOps-Starter-Code/blob/master/C1%20-%20Azure%20Infrastructure%20Operations/project/starter_files/project/IAMpacker.png?raw=true)
