#!/bin/bash
#FLUX: --job-name=strawberry-toaster-3679
#FLUX: -c=2
#FLUX: --priority=16

module load r/3.4.0
module load java/1.8.0_121
nextflow run  MCMC10_1000.nf -resume
