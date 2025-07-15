#!/bin/bash
#FLUX: --job-name=crunchy-house-5084
#FLUX: --priority=16

module load r/3.4.0
module load java/1.8.0_121
nextflow run  SMC30_1000_99999.nf -resume
