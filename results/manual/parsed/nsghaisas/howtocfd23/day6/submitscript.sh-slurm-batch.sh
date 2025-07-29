#!/bin/bash
#SBATCH --output=job.%J.out
#SBATCH --error=job.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=8

module load cuda/11.2
module load fftw/3.3.5
module load spack/0.17
module load nvhpc/22.1-gcc-11.2.0-axka
cd $SLURM_SBUMIT_DIR 
burger/burger.exe
