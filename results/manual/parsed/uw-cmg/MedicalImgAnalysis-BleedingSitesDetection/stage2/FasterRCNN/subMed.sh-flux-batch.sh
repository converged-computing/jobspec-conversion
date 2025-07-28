#!/bin/bash
#FLUX: --job-name=bumfuzzled-muffin-0569
#FLUX: --queue=slurm_priority
#FLUX: -t=1209780
#FLUX: --urgency=16

module load usermods
module load user/cuda
source activate chainercv
/srv/home/shenmr/anaconda3/envs/chainercv/bin/pip install scikit-image 
/srv/home/shenmr/anaconda3/envs/chainercv/bin/pip install cupy-cuda90 
/srv/home/shenmr/anaconda3/envs/chainercv/bin/pip install opencv-python
/srv/home/shenmr/anaconda3/envs/chainercv/bin/pip install Pillow
python train.py
