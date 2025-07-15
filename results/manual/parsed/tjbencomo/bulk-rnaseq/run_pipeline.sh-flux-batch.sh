#!/bin/bash
#FLUX: --job-name=frigid-muffin-1137
#FLUX: -t=43200
#FLUX: --priority=16

set -e
cd $(pwd)
echo "Starting up snakemake..."
snakemake --cluster-config cluster.json -j 499 \
    --use-singularity \
    --cluster 'sbatch -p {cluster.partition} -t {cluster.time} --mem {cluster.mem} -c {cluster.ncpus} -o {cluster.out}'
