#!/bin/bash
#SBATCH --job-name=myjobtest
#SBATCH --account=bbpj-delta-gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gpus-per-task=1
#SBATCH --mem=250g
#SBATCH --time=01:00:00
#SBATCH --partition=gpuA100x8
#SBATCH --constraint=ntasks-per-node=1

module reset # drop modules and explicitly load the ones needed
             # (good job metadata and reproducibility)
             # $WORK and $SCRATCH are now set
module load anaconda3_gpu  # ... or any appropriate modules
module list  # job documentation and metadata
echo "job is starting on `hostname`"
source activate global_finder310
!pip install tensorcircuit[jax]
srun python3 runner.py
echo "done"
