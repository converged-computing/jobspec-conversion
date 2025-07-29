#!/bin/bash
#SBATCH --job-name=hoomd
#SBATCH --account=see220002p
#SBATCH --output=%j.o
#SBATCH --error=%j.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100-16:1
#SBATCH --time=00:30:00
#SBATCH --partition=GPU-shared
#SBATCH --constraint=ntasks-per-node=5

echo "testing lj-npt on one gpu"
T=1.3
singularity exec --nv /ocean/projects/see220002p/shared/icomse_gpu.sif python lj-npt.py $SLURM_JOB_ID $T
