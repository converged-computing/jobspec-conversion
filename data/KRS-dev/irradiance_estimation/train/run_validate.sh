#!/bin/bash -l
#SBATCH --job-name="train ConvResNet"
#SBATCH --account="go41"
#SBATCH --time=0-01:00:00
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=24
#SBATCH --partition=normal
#SBATCH --constraint=gpu
#SBATCH --gres=gpu:1
#SBATCH --signal=SIGUSR1@90


export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# debugging flags (optional)
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1

module load daint-gpu 
source $SCRATCH/lightning-env/bin/activate

srun -ul python validate.py
