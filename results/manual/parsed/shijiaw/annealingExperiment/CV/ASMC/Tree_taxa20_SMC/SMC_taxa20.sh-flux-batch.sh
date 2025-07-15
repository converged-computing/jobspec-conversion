#!/bin/bash
#FLUX: --job-name=swampy-leg-6264
#FLUX: -c=2
#FLUX: --priority=16

module load r/3.4.0
module load java/1.8.0_121
nextflow run  SMC_taxa20.nf -resume
