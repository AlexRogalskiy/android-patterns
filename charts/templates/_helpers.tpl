{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "backend-android-patterns.name" -}}
{{- default .Chart.Name .Values.general.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Expand the app version of the chart.
*/}}
{{- define "backend-android-patterns.appVersion" -}}
{{- default .Chart.AppVersion | trunc 33 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "backend-android-patterns.fullname" -}}
{{- if .Values.general.fullnameOverride }}
{{- .Values.general.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.general.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "backend-android-patterns.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "backend-android-patterns.selectorLabels" -}}
app.kubernetes.io/name: {{ include "backend-android-patterns.name" . }}
app.kubernetes.io/instance: {{ .Release.Name | lower | quote }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "backend-android-patterns.labels" -}}
helm.sh/chart: {{ include "backend-android-patterns.chart" . }}
{{ include "backend-android-patterns.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Create the name of the tls secret for secure port
*/}}
{{- define "backend-android-patterns.tlsSecretName" -}}
{{- $fullname := include "backend-android-patterns.name" . -}}
{{- default (printf "%s-tls" $fullname) .Values.tls.secretName -}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "backend-android-patterns.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "backend-android-patterns.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
