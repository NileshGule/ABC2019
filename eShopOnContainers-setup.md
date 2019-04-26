# eShopOnContainers setup

## Infrastructure setup with Azure KAS cluster

```Powershell

initializeAKS.ps1 `
-resourceGroupName abceshopsg `
-clusterName aksIgniteCluster `
-dnsNamePrefix mgignite

```

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
