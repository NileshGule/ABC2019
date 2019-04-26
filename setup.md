# Setup of environment & Project

## Infrastructure setup with Azure KAS cluster

Provision AKS cluster using Powershell script from Powershell folder

```Powershell

initializeAKS.ps1

```

## Install Istio on AKS cluster

### Specify the Istio version that will be leveraged throughout these instructions

```Powershell

$ISTIO_VERSION="1.1.3"

$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -URI "https://github.com/istio/istio/releases/download/$ISTIO_VERSION/istio-$ISTIO_VERSION-win.zip" -OutFile "istio-$ISTIO_VERSION.zip"
Expand-Archive -Path "istio-$ISTIO_VERSION.zip" -DestinationPath .

cd istio-$ISTIO_VERSION
New-Item -ItemType Directory -Force -Path "C:/Program Files/Istio"
mv ./bin/istioctl.exe "C:/Program Files/Istio/"
$PATH = [environment]::GetEnvironmentVariable("PATH", "User")
[environment]::SetEnvironmentVariable("PATH", $PATH + "; C:/Program Files/Istio/", "User")

```

### Create secret for Kiali & Prometheus

```Powershell
$admin  = [System.Text.Encoding]::UTF8.GetBytes("admin")
[System.Convert]::ToBase64String($admin)

YWRtaW4=

$password  = [System.Text.Encoding]::UTF8.GetBytes("1f2d1e2e67df")
[System.Convert]::ToBase64String($password)

MWYyZDFlMmU2N2Rm

kubectl create ns istio-system

kubectl apply -f ~\Projects\ABC2019\Istio\grafana-secret.yaml

kubectl apply -f ~\Projects\ABC2019\Istio\kiali-secret.yaml

```

### InstallIstio from the downloaded folder using helm on AKS cluster

Following commands needs to be run relative to the Istio directory contents where they are extracted. My folder was ~\Projects\Istio-1.1.3

```Powershell

helm install install/kubernetes/helm/istio-init --name istio-init --namespace istio-system

helm install install/kubernetes/helm/istio --name istio --namespace istio-system `
--set global.controlPlaneSecurityEnabled=true `
--set servicegraph.enabled=true `
--set grafana.enabled=true `
--set tracing.enabled=true `
--set kiali.enabled=true

```

## Verify Istio install

```powershell

kubectl get svc --namespace istio-system --output wide

```

### Access Add ons

### Grafana

```powershell

kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}') 3000:3000

```

### Prometheus

```powershell

kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=prometheus -o jsonpath='{.items[0].metadata.name}') 9090:9090

```

### Jaegar

```powershell

kubectl port-forward -n istio-system $(kubectl get pod -n istio-system -l app=jaeger -o jsonpath='{.items[0].metadata.name}') 16686:16686

```

### Kiali

```powershell

kubectl port-forward -n istio-system $(kubectl get pod -n istio-system -l app=kiali -o jsonpath='{.items[0].metadata.name}') 20001:20001

```

### Enable automatic sidecar injection for Istio

```powershell

kubectl label namespace default istio-injection=enabled

```

Deploy application using Powershell script from Powershell folder

```Powershell

deployTechTalks-AKS.ps1

```