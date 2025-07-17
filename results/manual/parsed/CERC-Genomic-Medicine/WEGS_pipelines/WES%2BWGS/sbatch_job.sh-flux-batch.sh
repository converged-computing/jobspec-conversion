#!/bin/bash
#FLUX: --job-name=merge_bams
#FLUX: -t=10800
#FLUX: --urgency=16

module load nextflow
module load samtools
module load bedtools
nextflow run /path/to/Pipeline.nf -w /path/to/working/directory
