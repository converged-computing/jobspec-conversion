#!/bin/bash
#FLUX: --job-name=road_map_01
#FLUX: -c=4
#FLUX: -t=86400
#FLUX: --urgency=16

. ~/.bashrc
module load anaconda3/5.3.1
conda activate pytorch
conda install -n pytorch nb_conda_kernels
python train_road_map.py
