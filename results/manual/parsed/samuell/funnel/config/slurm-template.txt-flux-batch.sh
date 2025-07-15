#!/bin/bash
#FLUX: --job-name={{.TaskId}}
#FLUX: --urgency=16

{{if ne .Cpus 0 -}}
{{printf "#SBATCH --cpus-per-task %d" .Cpus}}
{{- end}}
{{if ne .RamGb 0.0 -}}
{{printf "#SBATCH --mem %.0fGB" .RamGb}}
{{- end}}
{{if ne .DiskGb 0.0 -}}
{{printf "#SBATCH --tmp %.0fGB" .DiskGb}}
{{- end}}
{{.Executable}} worker run --config {{.Config}} --task-id {{.TaskId}}
