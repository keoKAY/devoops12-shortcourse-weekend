{{- define "selector-template" }}
  selector:
    matchLabels:
      app: {{ .Values.appName.app }}-app
  template:
    metadata:
      labels:
        app: {{ .Values.appName.app }}-app
{{- end }}