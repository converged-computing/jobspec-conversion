#!/bin/bash
#FLUX: --job-name=spicy-avocado-6997
#FLUX: -c=20
#FLUX: --queue=bio
#FLUX: -t=1731600
#FLUX: --urgency=16

export OMP_NUM_THREADS='20'
export MKL_NUM_THREADS='20'

export OMP_NUM_THREADS=20
export MKL_NUM_THREADS=20
module --ignore-cache load Nextflow/21.08.0
nextflow run Braker.nf --genome=<genome.fna> --prot=<BrakerDB> --SRA=none --brakermode=<mode> --cpu=20 --currentpath=<PWD>
