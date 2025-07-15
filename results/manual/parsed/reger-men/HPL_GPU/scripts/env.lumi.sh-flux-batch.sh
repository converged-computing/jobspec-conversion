#!/bin/bash
#FLUX: --job-name=confused-cat-9445
#FLUX: --urgency=16

export MPICH_GPU_SUPPORT_ENABLED='1'
export MPICH_RANK_REORDER_DISPLAY='1'

module load LUMI/22.06 partition/G
module use /project/project_462000075/paklui/modulefiles
module load rocm/5.3.0-10670
module load cray-mpich/8.1.18
export MPICH_GPU_SUPPORT_ENABLED=1
export MPICH_RANK_REORDER_DISPLAY=1
