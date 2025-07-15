#!/bin/bash
#FLUX: --job-name=bricky-banana-9687
#FLUX: --urgency=16

. /hpc/mp/spack/opt/spack/linux-ubuntu20.04-zen2/gcc-10.3.0/\
lmod-8.7.2-uutt23puvwraegsi7w7ck3xbhrgk22mu/lmod/lmod/init/$(basename $SHELL)
module use /hpc/mp/modules
module purge
module load conda
if [ ! -d ~/.conda/envs/openmm ]; then
  mamba create -y -n openmm -c conda-forge openmm cudatoolkit=11.4
fi
conda activate openmm
if [ ! -d openmm_repo ]; then
  git clone --depth 1 https://github.com/openmm/openmm.git openmm_repo
fi
cd ./openmm_repo/examples
python3 ./benchmark.py --platform CUDA
