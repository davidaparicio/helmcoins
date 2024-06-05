{{/*
Expand the name of the chart.
*/}}
{{- define "generic.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "generic.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "generic.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "generic.labels" -}}
helm.sh/chart: {{ include "generic.chart" . }}
{{ include "generic.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "generic.selectorLabels" -}}
app.kubernetes.io/name: {{ include "generic.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "generic.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "generic.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service depending the port //TODO targetPort instead
https://i.sstatic.net/2bVEz.png
*/}}
{{- define "portName" -}}
  {{- $targetPort := int . -}}
  {{- if eq $targetPort 80 }} http
  {{- else if eq $targetPort 443 }} https
  {{- else if eq $targetPort 5432 }} pg
  {{- else if eq $targetPort 6379 }} redis
  {{- else if eq $targetPort 3306 }} mysql
  {{- else if eq $targetPort 27017 }} mongodb
  {{- else if eq $targetPort 9042 }} cassandra
  {{- else if eq $targetPort 5672 }} rabbitmq
  {{- else if eq $targetPort 25 }} smtp
  {{- else if eq $targetPort 587 }} smtps
  {{- else if eq $targetPort 21 }} ftp
  {{- else if eq $targetPort 990 }} ftps
  {{- else if eq $targetPort 22 }} ssh
  {{- else if eq $targetPort 53 }} dns
  {{- else if eq $targetPort 389 }} ldap
  {{- else if eq $targetPort 123 }} ntp
  {{- else if eq $targetPort 143 }} imap
  {{- else if eq $targetPort 993 }} imaps
  {{- else if eq $targetPort 110 }} pop3
  {{- else if eq $targetPort 995 }} pop3s
  {{- else if eq $targetPort 8080 }} http-alt
  {{- else if eq $targetPort 8443 }} https-alt
  {{- else }} unknown
  {{- end -}}
{{- end -}}