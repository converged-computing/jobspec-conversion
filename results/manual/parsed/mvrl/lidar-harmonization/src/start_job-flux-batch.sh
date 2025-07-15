#!/bin/bash
#FLUX: --job-name=harmonize_dublin
#FLUX: -c=32
#FLUX: --queue=V4V32_SKY32M192_L
#FLUX: -t=259200
#FLUX: --urgency=16

module purge
module load intel/19.0.4.243
module load impi/2019.4.243
source /home/dtjo223/.bashrc
conda activate lidar
grep -c ^processor /proc/cpuinfo
nvidia-smi
python $PSCRATCH/nja224_uksr/dtjo223/lidar-harmonization/src/run.py
