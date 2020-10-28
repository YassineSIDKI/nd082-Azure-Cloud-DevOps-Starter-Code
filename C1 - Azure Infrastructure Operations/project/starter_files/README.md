# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction

For this project, you will write a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure.

### Getting Started

1. Clone this repository

```
git clone https://github.com/YassineSIDKI/nd082-Azure-Cloud-DevOps-Starter-Code.git
```

2. Create your infrastructure as code

3. Update this README to reflect how someone would use your code.

### Dependencies

1. Create an [Azure Account](https://portal.azure.com)
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions

1. First, you should ensure that your are logged to azure. Run this command:

```
az login
```

You should get a response telling you that your are logged :

```
You have logged in. Now let us find all the subscriptions to which you have access...
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

2. Create an image by packer

First, you should add the following variables to you environment

```
ARM_CLIENT_ID
ARM_CLIENT_SECRET
ARM_SUBSCRIPTION_ID
ARM_TENANT_ID
```

Here is an article explaning how to get the correct variables: <link>

Then, run this command :

```
packer build PATH-TO/server.json
```

3. Create a vm by Terraform

From `variables.tf`you can edit the :

    - Location of your resources in the `variable`element
    - Indicate the number of azure vm instances you want to create in the `nb_instances`element

Then, you can simply run this command:

```
terraform apply PATH-TO/solution.plan
```

### Output

**Your words here**
