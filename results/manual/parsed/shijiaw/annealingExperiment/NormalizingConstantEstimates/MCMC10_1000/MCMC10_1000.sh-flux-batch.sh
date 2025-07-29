#!/bin/bash
#FLUX --job-name=ornery-spoon-8415
#FLUX -c=2
#FLUX -t=172800
#FLUX --urgency=16

module load r/3.4.0
module load java/1.8.0_121
nextflow run  MCMC10_1000.nf -resume
