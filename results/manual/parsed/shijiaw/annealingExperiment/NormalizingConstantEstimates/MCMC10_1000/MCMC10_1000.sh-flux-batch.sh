#!/bin/bash
#FLUX: --job-name=hairy-pancake-5369
#FLUX: -c=2
#FLUX: --urgency=16

module load r/3.4.0
module load java/1.8.0_121
nextflow run  MCMC10_1000.nf -resume
