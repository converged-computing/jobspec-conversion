#!/bin/bash
#SBATCH --job-name=scheduler
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2gb
#SBATCH --time=5-00:00:00

cd /mnt/work1/users/pughlab/bin/swgs
snakemake --cluster-config slurm/cluster.json \
--profile slurm \
--wrapper-prefix 'file:///mnt/work1/users/pughlab/references/snakemake-wrappers/' \
--use-conda \
--use-singularity \
--jobs 5 \
--rerun-incomplete
