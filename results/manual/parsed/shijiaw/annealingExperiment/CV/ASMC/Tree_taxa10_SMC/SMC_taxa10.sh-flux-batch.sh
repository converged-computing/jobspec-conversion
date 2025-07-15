#!/bin/bash
#FLUX: --job-name=conspicuous-bike-0099
#FLUX: -c=2
#FLUX: --priority=16

module load r/3.4.0
module load java/1.8.0_121
nextflow run  SMC_taxa10.nf -resume
