# eShopOnContainers setup

## Infrastructure setup with Azure KAS cluster

Create a Kubernetes cluster using `Azure Kubernetes Service` with following parameters

| Parameter | value |
|---| --- |
| Resource Group Name | `abceshopsg` |
| Cluster Name | `abceshopCluster`|
| Dns Prefix Name | `abceshopdns` |

*Note:* Visit [initializeAKS.ps1](Powershell/initializeAKS.ps1) for more details to know about the default parameters used while creating the AKS cluster.

The script also initializes `Helm` on the cluster with the `Tiller` account.

```Powershell

initializeAKS.ps1 `
-resourceGroupName abceshopsg `
-clusterName abceshopCluster `
-dnsNamePrefix abceshopdns

```

---

## Install eshoponcontainers using Helm charts

Make sure to clone the eshopOnContainers repository from https://github.com/NileshGule/eShopOnContainers

Run the deployment script from the directory `k8s/helm/deploy-all.ps1` from eshopOnContainers code repository

| Parameter | value |
|---| --- |
| External DNS name | `aks` |
| Cluster Name | `abceshopCluster`|
| AKS Resource Group Name | `abceshopsg` |
| Image Tag | `dev` |

```Powershell

.\deploy-all.ps1 `
-externalDns aks `
-aksName abceshopCluster `
-aksRg abceshopsg `
-imageTag dev

```

## Navigate to Kubernetes cluster dashboard

```Powershell

.\browseAKS.ps1 `
-resourceGroupName abceshopsg `
-clusterName abceshopCluster

```

## Enable large headers

```bash

kubectl apply -f aks-httpaddon-cfg.yaml

```

## Verify deployment

```bash

kubectl get deployment

kubectl get ing

```

## Access apps

http://eshop.d1a63e27c7884fda85de.southeastasia.aksapp.io

http://eshop.d1a63e27c7884fda85de.southeastasia.aksapp.io/webmvc

*Note:* The urls mentioned here will not be available after the demo is completed. In order to save costs, the AKS cluster is deleted after the demo / presentation and the url will vary when the new cluster is provisioned.