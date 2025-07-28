#!/bin/bash
#FLUX: --job-name=tsunami_lab_reis_gpu
#FLUX: -c=48
#FLUX: --queue=gpu_v100,gpu_p100,gpu_a100
#FLUX: -t=39600
#FLUX: --urgency=16

module load tools/python/3.8
module load compiler/gcc/11.2.0
module load nvidia/cuda/11.7
python3.8 -m pip install --user scons==4.0.1
python3.8 -m pip install --user distro
date
cd /beegfs/gi24ken/tsunami_lab
scons cxxO=-Ofast
./build/tsunami_lab -t 1 -u "Tsunami2d output/tohoku_gebco20_usgs_250m_displ.nc output/tohoku_gebco20_usgs_250m_bath.nc 18000" -c 4000
