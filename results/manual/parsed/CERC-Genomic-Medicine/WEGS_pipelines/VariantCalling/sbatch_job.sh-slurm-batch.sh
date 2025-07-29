#!/bin/bash
#FLUX: --job-name=variantCalling
#FLUX: -t=43200
#FLUX: --urgency=16

module load nextflow
module load singularity
module load bcftools
module load samtools
nextflow run /path/to/Pipeline.nf -w /path/to/working/directory
