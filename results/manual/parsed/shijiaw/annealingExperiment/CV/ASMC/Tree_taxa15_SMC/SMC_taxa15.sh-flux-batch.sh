#!/bin/bash
#FLUX: --job-name=bloated-toaster-3073
#FLUX: -c=2
#FLUX: --urgency=16

module load r/3.4.0
module load java/1.8.0_121
nextflow run  SMC_taxa15.nf -resume
