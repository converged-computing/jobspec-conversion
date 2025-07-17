#!/bin/bash
#FLUX: --job-name=purple-kerfuffle-5424
#FLUX: -t=172815
#FLUX: --urgency=16

module load r/3.4.0
module load java/1.8.0_121
nextflow run  SMC30_1000_999995.nf -resume
