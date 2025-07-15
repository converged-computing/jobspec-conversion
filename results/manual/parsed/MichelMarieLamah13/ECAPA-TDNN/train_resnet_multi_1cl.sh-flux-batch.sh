#!/bin/bash
#FLUX: --job-name=resnet_multi_1cl
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=604800
#FLUX: --urgency=16

source /etc/profile.d/conda.sh
conda activate ecapa_tdnn
python3 trainRESNETModelMulti_1cl.py
conda deactivate
