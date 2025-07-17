#!/bin/bash
#FLUX: --job-name=dinosaur-staircase-6980
#FLUX: -c=20
#FLUX: --queue=bio
#FLUX: -t=435600
#FLUX: --urgency=16

export OMP_NUM_THREADS='20'
export MKL_NUM_THREADS='20'

export OMP_NUM_THREADS=20
export MKL_NUM_THREADS=20
module --ignore-cache load Nextflow/21.08.0
nextflow run CRACOT.nf --genomes=genomes --lineage=Genomes.taxomonomy --list=positive-list.txt --cpu=20 --num=100 --taxolevel=<FIELD> --duplication=4 --replacement=0 --single=0 --hgtrate=none --hgtrandom=no --duplicationhgt=0 --replacementhgt=0 --singlehgt=0
