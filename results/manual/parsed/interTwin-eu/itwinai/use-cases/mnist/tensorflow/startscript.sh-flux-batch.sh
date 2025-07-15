#!/bin/bash
#FLUX: --job-name=PrototypeTest
#FLUX: -N=2
#FLUX: -c=4
#FLUX: --exclusive
#FLUX: --queue=batch
#FLUX: -t=1800
#FLUX: --priority=16

ml --force purge
ml Stages/2024 GCC/12.3.0 OpenMPI CUDA/12 MPI-settings/CUDA Python/3.11 HDF5 PnetCDF libaio mpi4py CMake cuDNN/8.9.5.29-CUDA-12
source ~/.bashrc
source ../../../envAItf_hdfml/bin/activate
srun itwinai exec-pipeline --config pipeline.yaml --pipe-key pipeline -o verbose=2
