#!/bin/bash
#FLUX: --job-name=example_name
#FLUX: --queue=cpu_short
#FLUX: -t=43200
#FLUX: --priority=16

module load nextflow
nextflow run /gpfs/data/davolilab/data/WGS/01-scripts/wgs-copynumber-workflow/wgs-copynumber.nf -with-report report-nextflow-copywriter-$(date +"%Y%m%d%H%m").html -resume
