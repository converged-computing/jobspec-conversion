#!/bin/bash
#FLUX: --job-name=1d_desktop_frame
#FLUX: --queue=gpu
#FLUX: -t=54000
#FLUX: --urgency=16

module load 2022r1
module load gpu
module load python/3.8.12-bohr45d
module load openmpi
module load py-tensorflow
srun python Model1D2S_DESKTOP.py
