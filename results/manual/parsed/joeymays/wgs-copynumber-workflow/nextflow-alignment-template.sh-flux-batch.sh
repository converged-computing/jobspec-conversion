#!/bin/bash
#FLUX: --job-name=example_name
#FLUX: --queue=cpu_short
#FLUX: -t=43200
#FLUX: --priority=16

module load nextflow
nextflow run /gpfs/data/davolilab/data/WGS/01-scripts/wgs-copynumber-workflow/wgs-alignment.nf -with-report report-nextflow-alignment-$(date +"%Y%m%d%H%m").html -resume
