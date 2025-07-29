#!/bin/bash
#SBATCH --job-name=finetune ConvResNet
#SBATCH --account=go41
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:1
#SBATCH --time=03:30:00
#SBATCH --constraint=ntasks-per-node=1,gpu

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
module load daint-gpu 
source $SCRATCH/lightning-env/bin/activate
srun -ul python finetune.py
