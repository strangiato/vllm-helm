# vllm

A Helm chart to deploy vLLM on OpenShift

![Version: 0.3.0](https://img.shields.io/badge/Version-0.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.26.0](https://img.shields.io/badge/AppVersion-v0.26.0-informational?style=flat-square)

## Installing the Chart

To access charts from this from the cli repository add it:

```sh
helm repo add <todo> <todo>
helm repo update <todo>
helm upgrade -i [release-name] <todo>/vllm
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
    repository: "<todo>
```

## Usage

### Quick Start

For a basic vLLM deployment with default settings:

```sh
helm upgrade -i my-vllm <todo>/vllm
```

## Configuration

For a complete list of all configuration options, see the [Values](#values) section below.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| configuration.cache.emptyDir | object | `{}` |  |
| configuration.cache.pvc.accessModes[0] | string | `"ReadWriteOnce"` |  |
| configuration.cache.size | string | `"20Gi"` |  |
| configuration.cache.type | string | `"emptyDir"` |  |
| configuration.env | object | `{}` |  |
| configuration.extraArgs[0] | string | `"--disable-access-log-for-endpoints=/health,/metrics,/ping"` |  |
| configuration.model.emptyDir | object | `{}` |  |
| configuration.model.hfModelDownload.enabled | bool | `true` |  |
| configuration.model.hfModelDownload.huggingfaceToken | string | `nil` |  |
| configuration.model.image.pullPolicy | string | `"IfNotPresent"` |  |
| configuration.model.image.reference | string | `"quay.io/redhat-ai-services/modelcar-catalog:granite-3.3-2b-instruct"` |  |
| configuration.model.image.type | string | `"modelCar"` |  |
| configuration.model.mountPath | string | `"/mnt/models"` |  |
| configuration.model.name | string | `"ibm-granite/granite-3.3-2b-instruct"` |  |
| configuration.model.pvc.accessModes[0] | string | `"ReadWriteOnce"` |  |
| configuration.model.pvc.size | string | `"20Gi"` |  |
| configuration.model.type | string | `"image"` |  |
| configuration.shm.size | string | `"2Gi"` |  |
| deploymentStrategy.type | string | `"RollingUpdate"` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.registry | string | `"registry.redhat.io"` |  |
| image.repository | string | `"rhaii/vllm-cuda-rhel9"` |  |
| image.tag | string | `"3.5.1"` |  |
| imagePullSecrets | list | `[]` |  |
| livenessProbe.failureThreshold | int | `2` |  |
| livenessProbe.httpGet.path | string | `"/health"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| livenessProbe.periodSeconds | int | `60` |  |
| livenessProbe.timeoutSeconds | int | `3` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations."prometheus.io/path" | string | `"/metrics"` |  |
| podAnnotations."prometheus.io/port" | string | `"8000"` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| readinessProbe.failureThreshold | int | `3` |  |
| readinessProbe.httpGet.path | string | `"/v1/models"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| readinessProbe.periodSeconds | int | `30` |  |
| readinessProbe.timeoutSeconds | int | `3` |  |
| replicaCount | int | `1` |  |
| resources.limits."nvidia.com/gpu" | int | `1` |  |
| resources.limits.cpu | int | `4` |  |
| resources.limits.memory | string | `"16Gi"` |  |
| resources.requests."nvidia.com/gpu" | int | `1` |  |
| resources.requests.cpu | int | `2` |  |
| resources.requests.memory | string | `"8Gi"` |  |
| route.annotations | object | `{}` |  |
| route.enabled | bool | `true` |  |
| route.subdomain | string | `""` |  |
| route.tls.enabled | bool | `true` |  |
| route.tls.insecureEdgeTerminationPolicy | string | `"Redirect"` |  |
| securityContext.allowPrivilegeEscalation | bool | `false` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service.port | int | `8000` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automount | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| startupProbe.failureThreshold | int | `180` |  |
| startupProbe.httpGet.path | string | `"/health"` |  |
| startupProbe.httpGet.port | string | `"http"` |  |
| startupProbe.periodSeconds | int | `10` |  |
| startupProbe.timeoutSeconds | int | `3` |  |
| tolerations[0].effect | string | `"NoSchedule"` |  |
| tolerations[0].key | string | `"nvidia.com/gpu"` |  |
| tolerations[0].operator | string | `"Exists"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)