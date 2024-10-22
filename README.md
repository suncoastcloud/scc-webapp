# SunCoast Cloud Consulting

## Project Description

This project demonstrates the capabilities of Azure, Bicep, Infrastructure as Code (IaC), DevOps, and automation. The solution uses Bicep, has a simple pipeline, and utilizes as many free or inexpensive Azure services as possible.

## Deployment Instructions

To deploy this project using Bicep, follow these steps:

1. Ensure you have the Azure CLI installed and logged in.
2. Navigate to the directory containing the `main.bicep` file.
3. Run the following command to deploy the resources:

```bash
az deployment group create --resource-group <resource-group-name> --template-file main.bicep
```

Replace `<resource-group-name>` with the name of your Azure resource group.

## Pipeline Setup Instructions

To set up the pipeline for this project, follow these steps:

1. Ensure you have an Azure DevOps account and a project created.
2. Navigate to the Pipelines section of your Azure DevOps project.
3. Create a new pipeline and select the repository containing this project.
4. Configure the pipeline to use the `azure-pipelines.yml` file in the root of the repository.
5. Save and run the pipeline to deploy the resources and the website.
