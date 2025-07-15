#!/bin/bash
#FLUX: --job-name=boopy-noodle-0526
#FLUX: -t=721800
#FLUX: --priority=16

source /conda/miniconda3/etc/profile.d/conda.sh
Nextflow=n/NextFlow/nextflow
module load singularity
$Nextflow run main.nf -profile GRCh37 -resume -with-trace -with-report -with-timeline  -with-dag flowchart.png
