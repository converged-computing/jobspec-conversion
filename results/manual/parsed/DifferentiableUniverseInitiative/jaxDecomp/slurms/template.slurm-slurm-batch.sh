#!/bin/bash
#SBATCH --job-name=Learning-jax-SPMD
#SBATCH --account=xyz@v100
#SBATCH --output=mpi_gpu_multi%j.out
#SBATCH --error=mpi_gpu_multi%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:4
#SBATCH --time=00:10:00
#SBATCH --constraint=v100-16g,ntasks-per-node=1

module purge
module load nvidia-compilers/23.9 cuda/11.8.0 cudnn/8.9.7.29-cuda  openmpi/4.1.1-cuda nccl/2.18.1-1-cuda cmake
module load python/3.10.4 && conda deactivate
source venv/bin/activate
set -x
srun python $1
