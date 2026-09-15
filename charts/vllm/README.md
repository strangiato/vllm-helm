# vllm

A Helm chart to deploy vLLM on OpenShift

![Version: 0.3.0](https://img.shields.io/badge/Version-0.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.26.0](https://img.shields.io/badge/AppVersion-v0.26.0-informational?style=flat-square)

## Installing the Chart

To access charts from this from the cli repository add it:

```sh
helm repo add rhai https://rhai-code.github.io/vllm/
helm repo update rhai
helm upgrade -i [release-name] rhai/vllm
```

To include a chart from this repository in an umbrella chart, include it in your dependencies in your `Chart.yaml` file.

```yaml
apiVersion: v2
name: example-chart
description: A Helm chart for Kubernetes
type: application

version: 0.1.0

appVersion: "1.16.0"

dependencies:
  - name: "vllm"
    version: "0.3.0"
    repository: "https://rhai-code.github.io/vllm/"
```

## Usage

### Quick Start

For a basic vLLM deployment with default settings:

```sh
helm upgrade -i my-vllm rhai/vllm
```

## Configuration

For a complete list of all configuration options, see the [Values](#values) section below.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Pod affinity rules for the vLLM workload. |
| configuration.cache.emptyDir | object | `{}` |  |
| configuration.cache.pvc.accessModes[0] | string | `"ReadWriteOnce"` |  |
| configuration.cache.size | string | `"20Gi"` | Size of the cache volume when type is emptyDir or the PVC request when type is pvc. |
| configuration.cache.type | string | `"emptyDir"` | Cache volume type for /home/vllm/.cache. Must be one of pvc or emptyDir. |
| configuration.env | object | `{}` | Additional environment variables for the vLLM container (merged into the chart ConfigMap). HF_HOME and HF_HUB_OFFLINE are managed by the chart. |
| configuration.extraArgs | list | `["--disable-access-log-for-endpoints=/health,/metrics,/ping"]` | Extra arguments passed to `vllm serve`. See https://docs.vllm.ai/en/latest/serving/engine_args.html |
| configuration.model.emptyDir | object | `{}` |  |
| configuration.model.hfModelDownload.enabled | bool | `true` | Download the model from Hugging Face at startup when type is pvc or emptyDir. Sets HF_HUB_OFFLINE=0 and mounts model storage read/write. |
| configuration.model.hfModelDownload.huggingfaceToken | string | `nil` | Hugging Face token (HF_TOKEN) when hfModelDownload.enabled is true. Required for gated models. |
| configuration.model.image.pullPolicy | string | `"IfNotPresent"` | Pull policy for the model OCI image when using modelCar or artifact storage. |
| configuration.model.image.reference | string | `"quay.io/redhat-ai-services/modelcar-catalog:granite-3.3-2b-instruct"` | OCI reference for model.image.type artifact (image volume) or modelCar sidecar/init image. |
| configuration.model.image.type | string | `"modelCar"` | OCI model packaging when model.type is image. Must be one of artifact or modelCar. |
| configuration.model.mountPath | string | `"/mnt/models"` | Mount path for model files (HF_HOME) and the local path passed to vllm serve when type is image. |
| configuration.model.name | string | `"ibm-granite/granite-3.3-2b-instruct"` |  |
| configuration.model.pvc.accessModes[0] | string | `"ReadWriteOnce"` |  |
| configuration.model.pvc.size | string | `"20Gi"` | PVC storage size when model.type is pvc, or emptyDir sizeLimit when model.type is emptyDir. |
| configuration.model.type | string | `"image"` | Model storage type. Must be one of image, pvc, or emptyDir. |
| configuration.shm.size | string | `"2Gi"` | Size of the in-memory emptyDir mounted at /dev/shm. |
| deploymentStrategy.type | string | `"RollingUpdate"` | Deployment strategy type (for example RollingUpdate or Recreate). |
| fullnameOverride | string | `""` | String to fully override fullname template. |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy for the vLLM runtime image. |
| image.registry | string | `"registry.redhat.io"` | Container image registry for the vLLM runtime image. |
| image.repository | string | `"rhaii/vllm-cuda-rhel9"` | Container image repository for the vLLM runtime image. |
| image.tag | string | `"3.5.1"` | Image tag for the vLLM runtime image. Defaults to the chart appVersion when empty. |
| imagePullSecrets | list | `[]` | Secrets for pulling images from private registries. See https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ |
| livenessProbe | object | `{"failureThreshold":2,"httpGet":{"path":"/health","port":"http"},"periodSeconds":60,"timeoutSeconds":3}` | Liveness probe for the vLLM HTTP endpoint. |
| nameOverride | string | `""` | String to partially override fullname template (will maintain the release name). |
| nodeSelector | object | `{}` | Node selector for scheduling the vLLM pod. |
| podAnnotations | object | `{"prometheus.io/path":"/metrics","prometheus.io/port":"8000"}` | Annotations added to the pod template. |
| podLabels | object | `{}` | Labels added to the pod template. |
| podSecurityContext | object | `{"runAsNonRoot":true}` | Security context for the vLLM pod. |
| readinessProbe | object | `{"failureThreshold":3,"httpGet":{"path":"/v1/models","port":"http"},"periodSeconds":30,"timeoutSeconds":3}` | Readiness probe for the vLLM HTTP endpoint. |
| replicaCount | int | `1` | Number of vLLM pod replicas. |
| resources | object | `{"limits":{"cpu":4,"memory":"16Gi","nvidia.com/gpu":1},"requests":{"cpu":2,"memory":"8Gi","nvidia.com/gpu":1}}` | CPU, memory, and accelerator resources for the vLLM container. |
| route.annotations | object | `{}` | Annotations added to the Route. |
| route.enabled | bool | `true` | Create an OpenShift Route for external access to the vLLM API. |
| route.subdomain | string | `""` | Optional Route subdomain (cluster-dependent). |
| route.tls.enabled | bool | `true` | Enable TLS termination on the Route. |
| route.tls.insecureEdgeTerminationPolicy | string | `"Redirect"` | OpenShift Route insecure edge termination policy when TLS is enabled. |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":false}` | Security context for the vLLM container. |
| service.port | int | `8000` | Port exposed by the Service and used by vllm serve. |
| service.type | string | `"ClusterIP"` | Kubernetes Service type for the vLLM API. |
| serviceAccount.annotations | object | `{}` | Annotations added to the ServiceAccount. |
| serviceAccount.automount | bool | `true` | Automount the ServiceAccount API token into the pod. |
| serviceAccount.create | bool | `true` | Create a dedicated ServiceAccount for the vLLM pod. |
| serviceAccount.name | string | `""` | ServiceAccount name. If empty and create is true, the chart fullname is used. |
| startupProbe | object | `{"failureThreshold":180,"httpGet":{"path":"/health","port":"http"},"periodSeconds":10,"timeoutSeconds":3}` | Startup probe for the vLLM HTTP endpoint. |
| tolerations | list | `[{"effect":"NoSchedule","key":"nvidia.com/gpu","operator":"Exists"}]` | Tolerations for scheduling the vLLM pod onto GPU (or other tainted) nodes. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)