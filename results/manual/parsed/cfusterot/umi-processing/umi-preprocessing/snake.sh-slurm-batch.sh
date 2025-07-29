#!/bin/bash
#SBATCH --job-name=preprocessing
#SBATCH --output=/data/gpfs-1/users/cofu10_c/scratch/P3473/slurm_logs/%x.%j.out
#SBATCH --error=/data/gpfs-1/users/cofu10_c/scratch/P3473/slurm_logs/%x.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000M
#SBATCH --time=1-00:00:00

snakemake \
    --nt \
    --jobs 250 \
    --restart-times 3 \
    --cluster-config /data/gpfs-1/users/cofu10_c/work/pipelines/umi-processing/config/cluster_config.yaml \
    --profile=cubi-v1 \
    --use-conda \
    --conda-frontend mamba \
    --printshellcmds \
    --rerun-incomplete \
    --scheduler greedy \
    --keep-going \
    --conda-prefix=/data/gpfs-1/users/cofu10_c/scratch/P3406/envs \
    --reason \
    --verbose \
    --keep-going \
