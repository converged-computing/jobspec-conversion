#!/bin/bash
#SBATCH --job-name={{.TaskId}}
#SBATCH --output={{.WorkDir}}/funnel-stdout
#SBATCH --error={{.WorkDir}}/funnel-stderr
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

{{if ne .Cpus 0 -}}
{{printf "#SBATCH --cpus-per-task %d" .Cpus}}
{{- end}}
{{if ne .RamGb 0.0 -}}
{{printf "#SBATCH --mem %.0fGB" .RamGb}}
{{- end}}
{{if ne .DiskGb 0.0 -}}
{{printf "#SBATCH --tmp %.0fGB" .DiskGb}}
{{- end}}
funnel worker run --taskID {{.TaskId}}
