#!/bin/bash
#FLUX: --job-name=hairy-hope-4980
#FLUX: --urgency=16

cd /mnt/work1/users/pughlab/bin/swgs
snakemake --cluster-config slurm/cluster.json \
--profile slurm \
--wrapper-prefix 'file:///mnt/work1/users/pughlab/references/snakemake-wrappers/' \
--use-conda \
--use-singularity \
--jobs 5 \
--rerun-incomplete
