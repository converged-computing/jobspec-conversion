#!/bin/bash
#SBATCH --job-name=TEST
#SBATCH --output=slurm-report.out
#SBATCH --error=slurm-report.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:20:00
#SBATCH --constraint=ntasks-per-node=12

export OMP_NUM_THREADS='12'

module purge
module load gcc/12
module load FFTW/3.3.10
module load OpenBLAS/0.3.23
module load openmpi-cuda/4.1.5
module load nvhpc/23.3
module load CUDA/12.1
module load intel/oneapi-2023.1.0
module load compiler/2023.1.0
module load mkl/2023.1.0
source $HOME/flare/bin/activate
nvidia-cuda-mps-control -d
export OMP_NUM_THREADS=12
flare-otf inputs.yaml
