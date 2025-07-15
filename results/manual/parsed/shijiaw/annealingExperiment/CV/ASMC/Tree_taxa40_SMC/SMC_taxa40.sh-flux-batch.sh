#!/bin/bash
#FLUX: --job-name=lovely-arm-9933
#FLUX: -c=2
#FLUX: --priority=16

module load r/3.4.0
module load java/1.8.0_121
nextflow run  SMC_taxa40.nf -resume
