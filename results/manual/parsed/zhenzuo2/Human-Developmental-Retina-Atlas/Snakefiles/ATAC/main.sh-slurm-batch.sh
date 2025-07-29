#!/bin/bash
#SBATCH --job-name=gpu_job
#SBATCH --output=gpu_job_%j.out
#SBATCH --error=gpu_job_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=50GB
#SBATCH --time=8-08:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --nodelist=mhgcp-g01

set -x
snakemake -j 5
