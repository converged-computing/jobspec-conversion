#!/bin/bash
#FLUX --job-name=carnivorous-underoos-3772
#FLUX -t=86400
#FLUX --urgency=16

set -e
cd $(pwd)
snakemake --cluster-config cluster.wes.json -j 499 \
    --use-singularity \
    --cluster 'sbatch -p {cluster.partition} -t {cluster.time} --mem {cluster.mem} -c {cluster.ncpus} -o {cluster.out}'
