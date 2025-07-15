#!/bin/bash
#FLUX: --job-name=psycho-chair-3468
#FLUX: -c=2
#FLUX: --urgency=16

module load r/3.4.0
module load java/1.8.0_121
nextflow run  SMC_taxa40.nf -resume
