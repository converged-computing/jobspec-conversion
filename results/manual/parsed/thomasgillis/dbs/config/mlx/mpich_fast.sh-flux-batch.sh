#!/bin/bash
#FLUX: --job-name=blank-ricecake-8154
#FLUX: -n=8
#FLUX: --queue=gpu
#FLUX: -t=7200
#FLUX: --priority=16

echo "loading modules"
module use /apps/USE/easybuild/release/2021.5/modules/all
module load GCC/10.3.0
module load Automake/1.16.3-GCCcore-10.3.0
module load Autoconf/2.71-GCCcore-10.3.0
module load libtool/2.4.6-GCCcore-10.3.0
module load CMake/3.20.1-GCCcore-10.3.0
module list
CLUSTER=mlx/mpich_fast make info
CLUSTER=mlx/mpich_fast make install
