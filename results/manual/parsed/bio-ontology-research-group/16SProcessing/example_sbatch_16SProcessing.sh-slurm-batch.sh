#!/bin/bash
#FLUX: --job-name=16S_NF
#FLUX: -c=12
#FLUX: --queue=batch
#FLUX: -t=7200
#FLUX: --urgency=16

module load nextflow
module load singularity
nextflow run 16SProcessing.nf --in_dir directory/with/fastq/files -profile singularity
