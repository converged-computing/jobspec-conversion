#!/bin/bash
#FLUX: --job-name=pusheena-lizard-4586
#FLUX: -c=12
#FLUX: --queue=batch
#FLUX: -t=7200
#FLUX: --priority=16

module load nextflow
module load singularity
nextflow run 16SProcessing.nf --in_dir directory/with/fastq/files -profile singularity
