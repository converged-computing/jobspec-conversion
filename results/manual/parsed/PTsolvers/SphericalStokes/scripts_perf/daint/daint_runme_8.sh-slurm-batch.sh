#!/bin/bash
#SBATCH --job-name=SphStokes_8
#SBATCH --account=c23
#SBATCH --output=SphStokes_8.%j.o
#SBATCH --error=SphStokes_8.%j.e
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=1,gpu

export JULIA_HDF5_PATH='$HDF5_ROOT'
export JULIA_CUDA_MEMORY_POOL='none'
export IGG_CUDAAWARE_MPI='1'
export MPICH_RDMA_ENABLED_CUDA='1'

module load daint-gpu
module load Julia/1.7.2-CrayGNU-21.09-cuda
module load cray-hdf5-parallel
export JULIA_HDF5_PATH=$HDF5_ROOT
export JULIA_CUDA_MEMORY_POOL=none
export IGG_CUDAAWARE_MPI=1
export MPICH_RDMA_ENABLED_CUDA=1
scp SphericalStokes_mxpu_pareff.jl data_io2.jl daint_submit_pareff.sh $SCRATCH/SphericalStokes/scripts/
pushd $SCRATCH/SphericalStokes/scripts
srun daint_submit_pareff.sh
