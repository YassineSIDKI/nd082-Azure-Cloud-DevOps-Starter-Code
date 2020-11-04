# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

## Introduction

In this project, you will create a scalable web server in azure using Packer and Terraform.
You will start by creating an azure image with packer, which will be user as a template for your servers, and then create all other necessary resources by terraform.
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

3. Install [Packer](https://www.packer.io/downloads). Then add packer path to your environment variables and run this command

```
packer -version
```

You should get the packer version as an output

4. Install [Terraform](https://www.terraform.io/downloads.html). Then add terraform path to your environment variables and run this command

```
terraform -version
```

You should get the terraform version as an output

## Instructions

### Create an image with packer

To create your azure image via packer, you should first set some variables in your environement.
These variables are : `ARM_CLIENT_ID` `ARM_SUBSCRIPTION_ID` `ARM_CLIENT_SECRET`, `ARM_TENANT_ID` and `ARM_RESOURCE_GROUP`

To do that, here are the steps to follow:

- Set **Service principale** vi **Azure active directory** . Here is a good video explaining how to do that: https://www.youtube.com/watch?v=Hg-YsUITnck
- Register an app via **App registrations**. You should get a view like below:

  ![alt text](https://raw.githubusercontent.com/YassineSIDKI/nd082-Azure-Cloud-DevOps-Starter-Code/master/C1%20-%20Azure%20Infrastructure%20Operations/project/starter_files/project/appRegistration.png)

- From your owned app, go to the app you want to use for this project, and copy `Application ID` and `Tenant ID`
- Add them to your environment variables by running this command :

```
export ARM_CLIENT_ID=`Application ID`
export ARM_TENANT_ID=`Tenant ID`
```

- Add client secret from **Certification & secrets**. You should see a view like this :

  ![alt text](https://github.com/YassineSIDKI/nd082-Azure-Cloud-DevOps-Starter-Code/blob/master/C1%20-%20Azure%20Infrastructure%20Operations/project/starter_files/project/clientSecret.png?raw=true)

- Add client_secret to your environment variables by running this command

```
export ARM_CLIENT_SECRET=`client secret`
```

- Go to Subscriptions from portal search, get your `subscription_id` and add it to evironment

```
export ARM_SUBSCRIPTION_ID=`subscription_id`
```

- From **Access control IAM**, add your app as an authorized app for this subscription.

- From Role assignement tab, you should have a view like this

  ![alt text](https://github.com/YassineSIDKI/nd082-Azure-Cloud-DevOps-Starter-Code/blob/master/C1%20-%20Azure%20Infrastructure%20Operations/project/starter_files/project/IAMpacker.png?raw=true)

- Add the resource group name, that you already created in azure and on which you want add your resources, to your environment variables:

```
export ARM_RESOURCE_GROUP=xxxx
```

- Run this command:

```
packer build server.json
```

**You can change the image configuration by editing the server.json**

### Output

You should get as an output a response like this :

![alt text](https://github.com/YassineSIDKI/nd082-Azure-Cloud-DevOps-Starter-Code/blob/master/C1%20-%20Azure%20Infrastructure%20Operations/project/starter_files/project/packerOutput.png?raw=true)

### Create resources with terraform

All what you should do, is to update the `variables.tf`

- Change the `packer_image_rg` default value with the good one
- Edit the `location` where you want to create resources. **It should be the same location where the resource group is created.**
- `nb_instances` is the number of servers in your clusters. You can change it at your conveniance.

- You can already create all your resources by running this command

```
terraform init
```

- This will generate terraform plugin folder and tfstate file. Then run this command :

```
terraform plan --out solution.plan
```

- This generate the `solution.plan` file. You should see, in the tail of your output, a response like this:

![alt text](https://github.com/YassineSIDKI/nd082-Azure-Cloud-DevOps-Starter-Code/blob/master/C1%20-%20Azure%20Infrastructure%20Operations/project/starter_files/project/tfPlanOutput.png?raw=true)

- If you are ok with that, apply it:

```
terraform apply solution.plan
```

- You should see in the tail of your output, a response like this:

  ![alt text](https://github.com/YassineSIDKI/nd082-Azure-Cloud-DevOps-Starter-Code/blob/master/C1%20-%20Azure%20Infrastructure%20Operations/project/starter_files/project/tfOutput.png?raw=true)

### Result in Azure Portal

You can check the resources created from azure portal :

![alt text](https://github.com/YassineSIDKI/nd082-Azure-Cloud-DevOps-Starter-Code/blob/master/C1%20-%20Azure%20Infrastructure%20Operations/project/starter_files/project/resultPortalAzure.png?raw=true)
