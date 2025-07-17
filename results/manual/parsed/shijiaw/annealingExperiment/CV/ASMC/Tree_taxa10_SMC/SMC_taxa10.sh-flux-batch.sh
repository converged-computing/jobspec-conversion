#!/bin/bash
#FLUX: --job-name=anxious-fudge-6421
#FLUX: -c=2
#FLUX: -t=86415
#FLUX: --urgency=16

module load r/3.4.0
module load java/1.8.0_121
nextflow run  SMC_taxa10.nf -resume
