#!/bin/bash
#FLUX: --job-name=DSE-Nord3
#FLUX: -t=86400
#FLUX: --urgency=16

export NXF_OPTS='-Xms500M -Xmx2G'

source_dir="$(pwd)"
report_dir="${source_dir}/reports"
module load nextflow/21.04.1
export NXF_OPTS="-Xms500M -Xmx2G"
nextflow run "${source_dir}/main.nf" \
	-with-report "${report_dir}/report.html" \
        -with-trace "${report_dir}/trace.txt" \
        -with-timeline "${report_dir}/timeline.html" \
	-with-dag "${report_dir}/flowchart.png" \
	-profile slurm \
	#-resume awesome_banach
