Param(
    [parameter(Mandatory=$false)]
    [string]$resourceGroupName="abc2019RG",
    [parameter(Mandatory=$false)]
    [string]$clusterName="abc2019TechTalks"
)

# Browse AKS dashboard
Write-Host "Browse AKS cluster $clusterName" -ForegroundColor Yellow
az aks browse `
--resource-group=$resourceGroupName `
--name=$clusterName