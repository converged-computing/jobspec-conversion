#!/bin/bash
#FLUX: --job-name=boopy-motorcycle-1716
#FLUX: -c=2
#FLUX: --priority=16

module load r/3.4.0
module load java/1.8.0_121
nextflow run  DSMC_taxa25.nf -resume
