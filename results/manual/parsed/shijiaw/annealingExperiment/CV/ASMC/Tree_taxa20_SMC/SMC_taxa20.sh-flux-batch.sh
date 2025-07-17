#!/bin/bash
#FLUX: --job-name=bloated-latke-4183
#FLUX: -c=2
#FLUX: -t=172815
#FLUX: --urgency=16

module load r/3.4.0
module load java/1.8.0_121
nextflow run  SMC_taxa20.nf -resume
