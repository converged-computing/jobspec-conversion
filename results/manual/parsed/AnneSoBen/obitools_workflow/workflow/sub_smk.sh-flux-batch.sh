#!/bin/bash
#FLUX: --job-name=scruptious-hope-4593
#FLUX: --priority=16

source activate snakemake
snakemake --cores 1 --unlock
snakemake --jobs  10 --cluster-config cluster.yaml --cluster "sbatch --mem {cluster.mem} -c {cluster.cpus}" --use-conda
