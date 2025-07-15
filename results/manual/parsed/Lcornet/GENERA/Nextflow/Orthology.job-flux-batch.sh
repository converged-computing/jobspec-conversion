#!/bin/bash
#FLUX: --job-name=chunky-despacito-4225
#FLUX: -c=20
#FLUX: --queue=bio
#FLUX: -t=435600
#FLUX: --urgency=16

export OMP_NUM_THREADS='20'
export MKL_NUM_THREADS='20'

export OMP_NUM_THREADS=20
export MKL_NUM_THREADS=20
module --ignore-cache load Nextflow/21.08.0
nextflow run Orthology.nf --infiles=infiles --mode=inference --core=yes --corelist=corelist --specific=yes --specificlist=specificlist --anvio=no --type=nucleotide --cpu=20 
