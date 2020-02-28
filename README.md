# Event Driven Batch Deployment Kit
### Using a push to storage event driven model, execute a templated workflow against an application in the Azure Container Registry executed in Azure Batch. For HPC based workflows, tightly coupled MPI based workflows are also supported. 

![Alt text](imgs/arch.png?raw=true "Event Driven Kit Arch")

## Deployment
After git cloning the kit, deploy the `storage-event-batch.json` in Azure Resource Manager filling in the relevant values. The ARM template is set to create if resource doesnt exist. As a tip keep track of the ids of the resources you deploy as you will need them later.

Upload the function from `StorageEventBatchFunction` in the Azure Function created in the ARM deployment
Deploy your docker image into the Azure Container Registry


