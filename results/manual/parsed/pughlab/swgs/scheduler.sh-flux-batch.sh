#!/bin/bash
#FLUX: --job-name=scheduler
#FLUX: --queue=all
#FLUX: -t=432000
#FLUX: --urgency=16

cd /mnt/work1/users/pughlab/bin/swgs
snakemake --cluster-config slurm/cluster.json \
--profile slurm \
--wrapper-prefix 'file:///mnt/work1/users/pughlab/references/snakemake-wrappers/' \
--use-conda \
--use-singularity \
--jobs 5 \
--rerun-incomplete
