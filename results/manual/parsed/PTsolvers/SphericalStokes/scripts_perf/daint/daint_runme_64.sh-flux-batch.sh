#!/bin/bash
#FLUX: --job-name=SphStokes_64
#FLUX: -N=64
#FLUX: --queue=normal
#FLUX: -t=540
#FLUX: --urgency=16

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
