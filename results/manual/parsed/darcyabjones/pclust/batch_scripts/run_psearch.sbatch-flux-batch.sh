#!/bin/bash
#FLUX: --job-name=loopy-pastry-6411
#FLUX: -c=28
#FLUX: --queue=workq
#FLUX: -t=86400
#FLUX: --urgency=16

module load nextflow/18.10.1-bin
nextflow run \
  -resume \
  -profile pawsey_zeus \
  ./psearch.nf \
    --max_cpus 28 \
    --proteins_db "sequences/proteins" \
    --global_profile "clusters/global_profile"
