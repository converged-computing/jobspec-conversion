#!/bin/bash
#FLUX: --job-name=convert_laz_np
#FLUX: -c=24
#FLUX: --queue=SAN32M512_L
#FLUX: -t=3600
#FLUX: --priority=16

module purge
module load intel/19.0.4.243
module load impi/2019.4.243
module load ccs/singularity
CONTAINER=/psratch/nja224_uksr/lidar_container
source /home/dtjo223/.bashrc
conda activate lidar
python $PSCRATCH/nja224_uksr/dtjo223/lidar-harmonization/src/datasets/tools/laz_to_numpy.py
