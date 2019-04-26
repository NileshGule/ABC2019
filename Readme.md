# Global Azure Bootcamp 2019

This repository contains all the code used for the demo presented at the Global Azure Bootcamp 2019 Singapore event.

---

## Code organization

- `Docker-compose V1`

Contains the docker-compose file in its simplest form

- `Docker-compose V2`

Contains the docker-compose files split into a base compose file and separate files for build and run scenarios. This is a preferred approach as it allows to have clear separation in terms of images which are built as part of application code and images which are used from other pre-built images. This also allows us to separate configurations between different environments like Dev / Integration / Production etc.

- `Helm`

Contains the Helm Role Based Access Control (RBAC) file for enabling proper access to Helm resources on AKS cluster using the cluster role binding feature.

- `Istio`

Contains the manifest files for adding Kubernetes secrets for `Kiali` and `Grafana` services.

- `k8s`

Contains Kubernetes Manifest files. `AKS` version exposes the `TechTalksWeb` and `TechTalksDB` using LoadBalancer. The data is also persisted outside of the container using `Persistent Volume (PV)` and `Persistent Volume Claim (PVC)`. The volume is backed by `Azure Disk`.

- `Powershell`

Contains the powershell scripts used for deploying application resources to AKS cluster. There is also script to initialize the AKS cluster.

- `src`

Contains the source code.
    
    - `TechTalksAPI` contains code for Web API project

    - `TechTalksDB` contains database initialization script

    - `TechTalksWeb` contains code for ASP.Net Core MVC frontend

---

## Deployment

Start with [setup.md](setup.md) which provisions the AKS cluster and deploys the `TechTalks` application. The cluster is setup with Istio Service Mesh.

To deploy the `eShopOnContainers` reference application, refer to the [eshopOnContainers-setup.md](eshopOnContainers-setup.md) file.

## Slides

The slides used during the presentation will be available at
- https://www.slideshare.net/nileshgule/presentations
- https://speakerdeck.com/nileshgule/

