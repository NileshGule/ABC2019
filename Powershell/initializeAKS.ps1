Param(
    [parameter(Mandatory=$false)]
    [string]$subscriptionName="Microsoft Azure Sponsorship",
    [parameter(Mandatory=$false)]
    [string]$resourceGroupName="abc2019RG",
    [parameter(Mandatory=$false)]
    [string]$resourceGroupLocaltion="South East Asia",
    [parameter(Mandatory=$false)]
    [string]$clusterName="abc2019TechTalks",
    [parameter(Mandatory=$false)]
    [string]$dnsNamePrefix="msignitetechtalks",
    [parameter(Mandatory=$false)]
    [int16]$workerNodeCount=3,
    [parameter(Mandatory=$false)]
    [string]$kubernetesVersion="1.13.5"
    
)

# Set Azure subscription name
Write-Host "Setting Azure subscription to $subscriptionName"  -ForegroundColor Yellow
az account set --subscription=$subscriptionName

# Create resource group name
Write-Host "Creating resource group $resourceGroupName in region $resourceGroupLocaltion" -ForegroundColor Yellow
az group create `
--name=$resourceGroupName `
--location=$resourceGroupLocaltion `
--output=jsonc

# Create AKS cluster
Write-Host "Creating AKS cluster $clusterName with resource group $resourceGroupName in region $resourceGroupLocaltion" -ForegroundColor Yellow
az aks create `
--resource-group=$resourceGroupName `
--name=$clusterName `
--node-count=$workerNodeCount `
--dns-name-prefix=$dnsNamePrefix `
--generate-ssh-keys `
--node-vm-size=Standard_D2_v2 `
--kubernetes-version=$kubernetesVersion `
--enable-addons http_application_routing

# Get credentials for newly created cluster
Write-Host "Getting credentials for cluster $clusterName" -ForegroundColor Yellow
az aks get-credentials `
--resource-group=$resourceGroupName `
--name=$clusterName

Write-Host "Successfully created cluster $clusterName with kubernetes version $kubernetesVersion and $workerNodeCount node(s)" -ForegroundColor Green

Write-Host "Creating cluster role binding for Kubernetes dashboard" -ForegroundColor Green
kubectl create clusterrolebinding kubernetes-dashboard -n kube-system --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard

Write-Host "Creating Tiller service account for Helm" -ForegroundColor Green
Set-Location ~/projects/ABC2019/Helm/
kubectl apply -f .\helm-rbac.yaml

Write-Host "Initializing Helm with Tiller service account" -ForegroundColor Green
helm init --service-account tiller

Set-Location ~/projects/ABC2019/Powershell