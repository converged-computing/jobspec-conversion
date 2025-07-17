#!/bin/bash
#FLUX: --job-name=lovable-animal-3189
#FLUX: --queue=defq
#FLUX: -t=721800
#FLUX: --urgency=16

source /conda/miniconda3/etc/profile.d/conda.sh
Nextflow=n/NextFlow/nextflow
module load singularity
$Nextflow run main.nf -profile GRCh37 -resume -with-trace -with-report -with-timeline  -with-dag flowchart.png
