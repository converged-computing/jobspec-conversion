#!/bin/bash
#FLUX: --job-name=pusheena-cattywampus-5242
#FLUX: -c=28
#FLUX: --queue=workq
#FLUX: -t=86400
#FLUX: --priority=16

module load nextflow/18.10.1-bin
nextflow run \
  -resume \
  -profile pawsey_zeus \
  ./psearch.nf \
    --max_cpus 28 \
    --proteins_db "sequences/proteins" \
    --global_profile "clusters/global_profile"
