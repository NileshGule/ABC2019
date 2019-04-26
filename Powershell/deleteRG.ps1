Param(
    [parameter(Mandatory=$false)]
    [string]$resourceGroupName="abc2019RG"
)

# Delete AKS cluster
Write-Host "Deleting resource group $resourceGroupName" -ForegroundColor Red
az group delete --name=$resourceGroupName --yes