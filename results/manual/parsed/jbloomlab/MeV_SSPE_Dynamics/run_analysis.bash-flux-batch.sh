#!/bin/bash
#FLUX: --job-name=purple-pancake-6045
#FLUX: -t=86400
#FLUX: --urgency=16

set -e
echo "Running snakemake..."
snakemake clean --cores 1
mkdir -p tmp
snakemake \
    --use-conda \
    --conda-frontend mamba \
    --conda-prefix ./env \
    -j 999 \
    --cluster-config cluster.yml \
    --cluster "sbatch -p {cluster.partition} -c {cluster.cpus} -t {cluster.time} -J {cluster.name} -o ./tmp/slurm-%x.%j.out" \
    --latency-wait 60
echo "Run of snakemake complete."
echo "Generating report..."
snakemake --report results/report.html
echo "Report created."
