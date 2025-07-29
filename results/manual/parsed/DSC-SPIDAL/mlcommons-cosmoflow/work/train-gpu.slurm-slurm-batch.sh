#!/bin/bash
#SBATCH --job-name=train-gpu-cosmoflow
#SBATCH --account=bii_dsc_community
#SBATCH --output=%u-%j.out
#SBATCH --error=%u-%j.err
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:4
#SBATCH --mem=32GB
#SBATCH --time=04:00:00
#SBATCH --partition=bii-gpu

export RUN_DIR='/scratch/$USER'
export IMAGE='/$RUN_DIR/cosmoflow/mlcommons-cosmoflow/work/cosmoflow.sif'
export SCRIPT_DIR='$RUN_DIR/cosmoflow/hpc'
export PROJECT='$RUN_DIR/cosmoflow'

hostname
echo "SLURM_CPUS_ON_NODE: $SLURM_CPUS_ON_NODE"
echo "SLURM_CPUS_PER_GPU: $SLURM_CPUS_PER_GPU"
echo "SLURM_GPU_BIND: $SLURM_GPU_BIND"
echo "SLURM_JOB_ACCOUNT: $SLURM_JOB_ACCOUNT"
echo "SLURM_JOB_GPUS: $SLURM_JOB_GPUS"
echo "SLURM_JOB_ID: $SLURM_JOB_ID"
echo "SLURM_JOB_PARTITION: $SLURM_JOB_PARTITION"
echo "SLURM_JOB_RESERVATION: $SLURM_JOB_RESERVATION"
echo "SLURM_SUBMIT_HOST: $SLURM_SUBMIT_HOST"
module purge
module load singularity
nvidia-smi
export RUN_DIR=/scratch/$USER
export IMAGE=/$RUN_DIR/cosmoflow/mlcommons-cosmoflow/work/cosmoflow.sif
export SCRIPT_DIR=$RUN_DIR/cosmoflow/hpc
export PROJECT=$RUN_DIR/cosmoflow
cd $RUN_DIR
ls -lisa
ls -lisa $SCRIPT_DIR/cosmoflow/train.py
ls -lisa $PROJECT/mlcommons-cosmoflow/configs/rivanna/cosmo-large.yaml
singularity exec --nv $IMAGE python $SCRIPT_DIR/cosmoflow/train.py $PROJECT/mlcommons-cosmoflow/configs/rivanna/cosmo-large.yaml
