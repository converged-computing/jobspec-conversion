#!/bin/bash
#SBATCH --job-name=PrototypeTest
#SBATCH --account=intertwin
#SBATCH --output=job.out
#SBATCH --error=job.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:4
#SBATCH --time=00:30:00
#SBATCH --partition=batch
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1

ml --force purge
ml Stages/2024 GCC/12.3.0 OpenMPI CUDA/12 MPI-settings/CUDA Python/3.11 HDF5 PnetCDF libaio mpi4py CMake cuDNN/8.9.5.29-CUDA-12
source ~/.bashrc
source ../../../envAItf_hdfml/bin/activate
srun itwinai exec-pipeline --config pipeline.yaml --pipe-key pipeline -o verbose=2
