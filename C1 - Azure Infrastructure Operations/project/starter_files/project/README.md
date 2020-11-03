# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction

In this project, you will create a scalable web server in azure using Packer and Terraform.

### Getting Started

To get started, you will need to:

1. Clone this repository

```
git clone https://github.com/YassineSIDKI/nd082-Azure-Cloud-DevOps-Starter-Code.git
```

2. Install all dependencies (section below) and ensure that all of them are well set

### Dependencies

1. Create an [Azure Account](https://portal.azure.com)
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
   Tap this command

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

Add packer path to your environment variable and tap this command

```
packer -version
```

you should get the packer version

4. Install [Terraform](https://www.terraform.io/downloads.html)
   Add terraform path to your environment variable and tap this command

```
terraform -version
```

you should get the terraform version

### Instructions

Once you setup your environement, you should follow the instructions bellow :

1. Creating a policy (Optional)

We will create a policy to deny creating resoucres without tags. This is up to you, if you are not intereseted to use this policy you can skip to next section.

You should first create the policy based on the policy.json

```
az policy create
```

Then assign it :

```
az policy assingment
```

2. Creating packer image

To create your azure image via packer, you should first set some variables in your environement.
These variables are : `client_id` `subscription_id` `client_secret` and `tenant_id`

You should set what is called Azure active directory service principale. Here is a good tutorial explaining how to do that: https://www.youtube.com/watch?v=Hg-YsUITnck

After doing it, you should see something like this

From the application view you can get, Application_id and tenant_id

You can get the client_secret from this view

Go to subscription, IAM and add your app as contributor

When you are done with this, you should add your variable to environment like this

```
export ARM_CLIENT_ID=''
export ARM_CLIENT_SECRET=''
export ARM_SUBSCRIPTION_ID=''
export ARM_TENANT_ID=''
```

You should also add your resource group name, which you created already

```
ARM_RESOURCE_GROUP
```

Read the server.json first to see if you are ok with image configuration.

After you finish, run this command:

```
packer build server.json
```

3. Create resources with terraform

First you should update the variables.tf

The first value you should change is the packer image resource group

and the location where you want to create your resources

The other variables depend on which configuration you want. Here is the details of each one:

-
-
-

After changing the variables, you are done (Cool isn't it :) )

You can already create all your resources now by running this command

```
terraform plan --out solution.plan

terraform apply solution.plan
yes
```

3. Create a vm by Terraform

### Output

You should get the following message:

```
Apply complete! Resources: 8 added, 0 changed, 0 destroyed.
```
