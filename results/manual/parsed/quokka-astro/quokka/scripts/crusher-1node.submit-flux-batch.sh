#!/bin/bash
#FLUX: --job-name=butterscotch-fork-2840
#FLUX: -c=7
#FLUX: --gpus-per-task=1
#FLUX: --urgency=16

export FI_MR_CACHE_MAX_COUNT='0  # libfabric disable caching'
export MPICH_GPU_SUPPORT_ENABLED='1'
export MPICH_OFI_NIC_POLICY='NUMA'

export FI_MR_CACHE_MAX_COUNT=0  # libfabric disable caching
export MPICH_GPU_SUPPORT_ENABLED=1
export MPICH_OFI_NIC_POLICY=NUMA
srun build/src/HydroBlast3D/test_hydro3d_blast tests/benchmark_unigrid_512.in
