#!/bin/bash
#FLUX: --job-name=astute-diablo-4819
#FLUX: -c=28
#FLUX: --queue=workq
#FLUX: -t=86400
#FLUX: --urgency=16

module load nextflow/18.10.1-bin
nextflow run \
  -resume \
  -profile pawsey_zeus \
  ./pupdate.nf \
    --max_cpus 28 \
    --nomsa \
    --proteins "data/phi45.fas" \
    --global_clusters "global_clusters" \
    --global_seqs "global_seqs" 
