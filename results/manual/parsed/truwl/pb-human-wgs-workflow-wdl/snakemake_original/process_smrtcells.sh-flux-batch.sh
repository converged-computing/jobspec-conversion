#!/bin/bash
#FLUX: --job-name=butterscotch-taco-7405
#FLUX: --urgency=16

umask 002
snakemake --reason \
    --rerun-incomplete \
    --keep-going \
    --local-cores 1 \
    --jobs 500 \
    --max-jobs-per-second 1 \
    --use-conda \
    --latency-wait 120 \
    --cluster-config workflow/process_smrtcells.cluster.yaml \
    --cluster "sbatch --account={cluster.account} \
                      --partition={cluster.partition} \
                      --cpus-per-task={cluster.cpus} \
                      --output={cluster.out} {cluster.extra} " \
    --snakefile workflow/process_smrtcells.smk
