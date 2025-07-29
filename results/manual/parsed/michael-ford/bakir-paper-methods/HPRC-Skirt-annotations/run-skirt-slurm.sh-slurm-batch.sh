#!/bin/bash
#SBATCH --job-name=run-skirt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --gres=lscratch:200
#SBATCH --mem=4G
#SBATCH --time=1-00:00:00

export TMPDIR='/lscratch/$SLURM_JOB_ID'

module load nextflow
export TMPDIR=/lscratch/$SLURM_JOB_ID
nextflow run run-skirt.nf \
-profile biowulf \
