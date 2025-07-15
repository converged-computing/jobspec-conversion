#!/bin/bash
#FLUX: --job-name=ornery-soup-8604
#FLUX: --urgency=16

module load r/3.4.0
module load java/1.8.0_121
nextflow run  SMC30_1000_999995.nf -resume
