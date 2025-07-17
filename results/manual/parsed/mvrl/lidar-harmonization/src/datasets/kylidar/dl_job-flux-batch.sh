#!/bin/bash
#FLUX: --job-name=intensity_harmonization
#FLUX: -c=24
#FLUX: --queue=CAL48M192_D
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load intel/19.0.4.243
module load impi/2019.4.243
module load ccs/singularity
CONTAINER=/pscratch/nja224_uksr/lidar_container
source /home/dtjo223/.bashrc
conda activate lidar
python ~/workspace/lidar-harmonization/src/dataset/kylidar/dl_kylidar.py
