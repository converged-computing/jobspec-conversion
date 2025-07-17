#!/bin/bash
#FLUX: --job-name=evasive-lizard-0508
#FLUX: -t=172800
#FLUX: --urgency=16

module load openmind/anaconda/3-2019.10; module load openmind/cuda/9.1;
source activate mesh_funcspace;
python /om/user/katiemc/occupancy_networks/train.py /om/user/katiemc/occupancy_networks/configs/unconditional/sample_complexity/double_chair.yaml
