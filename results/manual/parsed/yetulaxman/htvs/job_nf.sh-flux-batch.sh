#!/bin/bash
#FLUX --job-name=phat-punk-7977
#FLUX -n=10
#FLUX -c=2
#FLUX --queue=small
#FLUX -t=610
#FLUX --urgency=16

module load maestro
module load bioconda
source activate nextflow
nextflow run  test_real.nf
