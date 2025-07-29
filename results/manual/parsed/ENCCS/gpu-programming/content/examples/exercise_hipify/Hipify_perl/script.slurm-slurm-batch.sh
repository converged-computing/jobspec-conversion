#!/bin/bash
#SBATCH --job-name=test.hip
#SBATCH --account=project_465000485
#SBATCH --output=%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --time=00:10:00
#SBATCH --partition=eap
#SBATCH --constraint=ntasks-per-node=1

module load CrayEnv
module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm
srun ./executable.hip.exe
