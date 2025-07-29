#!/bin/bash
#SBATCH --job-name=train-cosmoflow
#SBATCH --account=bii_dsc_community
#SBATCH --output=%u-%j.out
#SBATCH --error=%u-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=32GB
#SBATCH --time=00:30:00
#SBATCH --constraint=a100_80gb

export SIF_DIR='/scratch/$USER/cosmoflow'
export USER_CONTAINER_DIR='/scratch/$USER/.singularity'
export COSMOFLOW='$SIF_DIR/hpc/cosmoflow'

module purge
module load singularity
export SIF_DIR=/scratch/$USER/cosmoflow
export USER_CONTAINER_DIR=/scratch/$USER/.singularity
export COSMOFLOW=$SIF_DIR/hpc/cosmoflow
cd $SIF_DIR
singularity run --nv $USER_CONTAINER_DIR/cosmoflow-gpu_mlperf-v1.0.sif $SIF_DIR/train.py
