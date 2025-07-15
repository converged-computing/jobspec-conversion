#!/bin/bash
#FLUX: --job-name=eccentric-muffin-6816
#FLUX: -c=2
#FLUX: --priority=16

module load r/3.4.0
module load java/1.8.0_121
nextflow run  DSMC_taxa15.nf -resume
