#!/bin/bash
#FLUX: --job-name=desk2df
#FLUX: --queue=gpu
#FLUX: -t=82800
#FLUX: --urgency=16

module load 2022r1
module load gpu
module load python/3.8.12-bohr45d
module load openmpi
module load py-tensorflow
srun python Model2D_DESKTOP_FRAME.py
