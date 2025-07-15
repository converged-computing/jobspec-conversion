#!/bin/bash
#FLUX: --job-name=bloated-poo-5505
#FLUX: -n=10
#FLUX: -c=2
#FLUX: --queue=small
#FLUX: -t=610
#FLUX: --urgency=16

module load maestro
module load bioconda
source activate nextflow
nextflow run  test_real.nf
