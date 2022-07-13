{{/* vim: set filetype=mustache: */}}

{{/*
Name of the application.
*/}}
{{- define "fullname" -}}
  {{- if .Values.appName -}}
    {{- printf "%s" .Values.appName -}}
  {{- else -}}
    {{- printf "cheeseshop" -}}
  {{- end -}}
{{- end -}}

{{/*
Chart name and version as used by the chart label.
*/}}
{{- define "chartname" -}}
  {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Application selector used by other components like deployment or service.
*/}}
{{- define "app.selector" -}}
app: {{ template "fullname" . }}
{{- end -}}


{{/*
Labels used by the objects definitions
*/}}
{{- define "app.labels" -}}
release: {{ .Release.Name }}
app: {{ template "fullname" . }}
{{- end -}}


{{/*
Standard set of labels used by all components, used to decsribe source chart.
*/}}
{{- define "chart.labels" -}}
chart: {{ template "chartname" . }}
heritage: {{ .Release.Service }}
{{- end -}}

{{/*
Docker image of the ervice deployment.
*/}}
{{- define "container.image" -}}
  {{- $repo := required "A valid docker repo value is required" .Values.container.image.repo -}}
  {{- $path := required "A valid docker path value is required" .Values.container.image.path -}}
  {{- $tag := required "A valid docker tag value is required" .Values.container.image.tag -}}
  {{- printf "%s%s:%s" $repo $path $tag -}}
{{- end -}}
