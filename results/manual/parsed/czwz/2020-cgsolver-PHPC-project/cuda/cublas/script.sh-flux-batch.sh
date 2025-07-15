#!/bin/bash
#FLUX: --job-name=stanky-taco-4569
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --priority=16

source /ssoft/spack/bin/slmodules.sh -s  x86_E5v2_Mellanox_GPU
module load gcc cuda
module load openblas
srun ./conjugategradient lap2D_5pt_n100.mtx
