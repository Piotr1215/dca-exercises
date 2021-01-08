# Define variables
RG="<resource group name where storage account is>"
AKS_PERS_STORAGE_ACCOUNT_NAME="<storage account name>"

# Retrieve storage key
STORAGEKEY=$(az storage account keys list --account-name $AKS_PERS_STORAGE_ACCOUNT_NAME --resource-group $RG \
                                          --query "[?keyName == 'key1'].value" -o tsv)

echo $AKS_PERS_STORAGE_ACCOUNT_NAME
echo $STORAGEKEY

# Create secret to enable the pod to mount the PVC
kubectl create secret generic azure-secret --from-literal=azurestorageaccountname=$AKS_PERS_STORAGE_ACCOUNT_NAME \
                                           --from-literal=azurestorageaccountkey=$STORAGEKEY