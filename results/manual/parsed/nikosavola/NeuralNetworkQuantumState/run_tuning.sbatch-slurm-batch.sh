#!/bin/bash
#SBATCH --job-name=nnqs_training
#SBATCH --output=nnqs_training.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=3GB
#SBATCH --time=06:00:00

module load anaconda gcc openmpi
pip install --upgrade "jax[cpu]" "ray[tune]" "netket[mpi]" hyperopt hiplot typing-extensions
srun python run_tuning.py --num_samples 300
