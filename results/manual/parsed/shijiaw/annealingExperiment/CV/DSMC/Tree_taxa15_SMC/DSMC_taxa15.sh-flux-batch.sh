#!/bin/bash
#FLUX: --job-name=misunderstood-omelette-1278
#FLUX: -c=2
#FLUX: -t=86415
#FLUX: --urgency=16

module load r/3.4.0
module load java/1.8.0_121
nextflow run  DSMC_taxa15.nf -resume
