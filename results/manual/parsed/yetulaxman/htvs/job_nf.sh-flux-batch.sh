#!/bin/bash
#FLUX --job-name=tart-mango-5267
#FLUX -n=10
#FLUX -c=2
#FLUX --queue=small
#FLUX -t=610
#FLUX --urgency=16

module load maestro
module load bioconda
source activate nextflow
nextflow run  test_real.nf
