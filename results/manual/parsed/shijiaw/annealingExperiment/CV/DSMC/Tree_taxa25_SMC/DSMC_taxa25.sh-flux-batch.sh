#!/bin/bash
#FLUX: --job-name=creamy-staircase-7778
#FLUX: -c=2
#FLUX: -t=172815
#FLUX: --urgency=16

module load r/3.4.0
module load java/1.8.0_121
nextflow run  DSMC_taxa25.nf -resume
