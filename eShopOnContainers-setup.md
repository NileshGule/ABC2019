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

```Powershell

.\deploy-all.ps1 `
-externalDns aks `
-aksName aksIgniteCluster `
-aksRg MSIgniteSG `
-imageTag dev

```

## Enable large headers

```bash

kubectl apply -f aks-httpaddon-cfg.yaml

```

kubectl get deployment
kubectl get ing
