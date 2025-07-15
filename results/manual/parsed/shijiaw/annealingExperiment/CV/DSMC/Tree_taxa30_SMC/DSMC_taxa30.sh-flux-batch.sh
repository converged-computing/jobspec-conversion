#!/bin/bash
#FLUX: --job-name=hello-hope-8611
#FLUX: -c=2
#FLUX: --urgency=16

module load r/3.4.0
module load java/1.8.0_121
nextflow run  DSMC_taxa30.nf -resume
