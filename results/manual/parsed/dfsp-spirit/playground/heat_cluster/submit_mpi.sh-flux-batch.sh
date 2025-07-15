#!/bin/bash
#FLUX: --job-name=spy_heat
#FLUX: -N=2
#FLUX: --queue=general
#FLUX: -t=600
#FLUX: --priority=16

module load anaconda/3/2021.11
conda activate heat
module load openmpi/4
module load netcdf-mpi/4.8.1
module load mpi4py/3.0.3
module load gpytorch/gpu-cuda-11.2/pytorch-1.9.0/1.5.1
SPYTMPDIR=/ptmp ~/develop/playground/heat_cluster/syncopy_heat_script.py
