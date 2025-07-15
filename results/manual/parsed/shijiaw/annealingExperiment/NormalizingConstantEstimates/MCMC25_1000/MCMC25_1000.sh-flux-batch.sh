#!/bin/bash
#FLUX: --job-name=purple-chair-6507
#FLUX: -c=2
#FLUX: --urgency=16

module load r/3.4.0
module load java/1.8.0_121
nextflow run  MCMC25_1000.nf -resume
