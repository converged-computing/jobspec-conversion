#!/bin/bash
#FLUX: --job-name=gloopy-lemur-4555
#FLUX: -c=20
#FLUX: --queue=bio
#FLUX: -t=435600
#FLUX: --urgency=16

export OMP_NUM_THREADS='20'
export MKL_NUM_THREADS='20'

export OMP_NUM_THREADS=20
export MKL_NUM_THREADS=20
module --ignore-cache load Nextflow/21.08.0
nextflow run Genome-downloader.nf --taxolevel=<FIELD1> --group=<FIELD2> --genbank=yes --dRep=no --ignoreGenomeQuality=no --cpu=20 
