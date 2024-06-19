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
{{- if .Chart.IsRoot }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
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
Generate Random Strings
Example: random-key: {{ include "randomString" 12 | quote }}
*/}}
{{- define "randomString" -}}
{{- $length := default 8 . -}}
{{- $chars := "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" -}}
{{- $result := "" -}}
{{- range seq 1 $length -}}
{{- $index := randInt 0 (len $chars | int) -}}
{{- $result = printf "%s%s" $result (index $chars $index) -}}
{{- end -}}
{{- $result -}}
{{- end -}}

{{/*
Create the name of the service depending the port //TODO targetPort instead
https://i.sstatic.net/2bVEz.png
*/}}
{{- define "portName" -}}
  {{- $namedPort:= . | toString -}}
  {{- $portMap := dict
    80 "http"
    443 "https"
    5432 "pg"
    6379 "redis"
    3306 "mysql"
    27017 "mongodb"
    9042 "cassandra"
    5672 "rabbitmq"
    25 "smtp"
    587 "smtps"
    21 "ftp"
    990 "ftps"
    22 "ssh"
    53 "dns"
    389 "ldap"
    123 "ntp"
    143 "imap"
    993 "imaps"
    110 "pop3"
    995 "pop3s"
    8080 "http-alt"
    8443 "https-alt"
  -}}
  {{- index $portMap $namedPort | default "unknown" | quote -}}
{{- end -}}