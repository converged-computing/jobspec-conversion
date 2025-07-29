#!/bin/bash
#FLUX: --job-name=delicious-house-4727
#FLUX: -t=172815
#FLUX: --urgency=16

module load r/3.4.0
module load java/1.8.0_121
nextflow run  SMC30_100_99999.nf -resume
