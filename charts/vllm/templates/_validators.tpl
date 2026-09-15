{{/*
Validate configuration.model.type.
*/}}
{{- define "vllm.validateModelType" -}}
{{- $validTypes := list "image" "pvc" "emptyDir" }}
{{- if not (has .Values.configuration.model.type $validTypes) }}
{{- fail (printf "configuration.model.type must be one of: %s" (join ", " $validTypes)) }}
{{- end }}
{{- end }}

{{/*
Validate configuration.model.image.type when model storage is an OCI image.
*/}}
{{- define "vllm.validateModelImageType" -}}
{{- if eq .Values.configuration.model.type "image" }}
{{- $validImageTypes := list "artifact" "modelCar" }}
{{- if not (has .Values.configuration.model.image.type $validImageTypes) }}
{{- fail (printf "configuration.model.image.type must be one of: %s when configuration.model.type is image" (join ", " $validImageTypes)) }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Validate configuration.model.mountPath (all model storage types).
*/}}
{{- define "vllm.validateModelMountPath" -}}
{{- if not .Values.configuration.model.mountPath }}
{{- fail "configuration.model.mountPath is required" }}
{{- end }}
{{- end }}

{{/*
Validate model fields when storage type is an OCI image.
*/}}
{{- define "vllm.validateModelImageStorage" -}}
{{- if eq .Values.configuration.model.type "image" }}
{{- if not .Values.configuration.model.image.reference }}
{{- fail "configuration.model.image.reference is required when configuration.model.type is image" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Validate model fields when storage type is a PVC.
*/}}
{{- define "vllm.validateModelPvcStorage" -}}
{{- if eq .Values.configuration.model.type "pvc" }}
{{- if not .Values.configuration.model.name }}
{{- fail "configuration.model.name is required when configuration.model.type is pvc" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Validate PVC / emptyDir model volume size.
*/}}
{{- define "vllm.validateModelPvcSize" -}}
{{- $model := .Values.configuration.model }}
{{- if or (eq $model.type "pvc") (eq $model.type "emptyDir") }}
{{- if not $model.pvc.size }}
{{- fail "configuration.model.pvc.size is required when configuration.model.type is pvc or emptyDir" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Validate Hugging Face download settings for non-image model storage.
*/}}
{{- define "vllm.validateHfModelDownload" -}}
{{- $model := .Values.configuration.model }}
{{- if and (ne $model.type "image") $model.hfModelDownload.enabled }}
{{- if not $model.hfModelDownload.huggingfaceToken }}
{{- fail "configuration.model.hfModelDownload.huggingfaceToken is required when configuration.model.hfModelDownload.enabled is true and configuration.model.type is not image" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Validate configuration.cache.type.
*/}}
{{- define "vllm.validateCacheType" -}}
{{- $validTypes := list "pvc" "emptyDir" }}
{{- if not (has .Values.configuration.cache.type $validTypes) }}
{{- fail (printf "configuration.cache.type must be one of: %s" (join ", " $validTypes)) }}
{{- end }}
{{- end }}

{{/*
Run all validation checks.
*/}}
{{- define "vllm.validateAll" -}}
{{- include "vllm.validateModelType" . }}
{{- include "vllm.validateModelMountPath" . }}
{{- include "vllm.validateModelImageType" . }}
{{- include "vllm.validateModelImageStorage" . }}
{{- include "vllm.validateModelPvcStorage" . }}
{{- include "vllm.validateModelPvcSize" . }}
{{- include "vllm.validateHfModelDownload" . }}
{{- include "vllm.validateCacheType" . }}
{{- end }}
