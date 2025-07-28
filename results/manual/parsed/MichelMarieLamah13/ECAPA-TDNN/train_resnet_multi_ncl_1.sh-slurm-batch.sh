#!/bin/bash
#FLUX: --job-name=resnet_multi_ncl_1
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=604800
#FLUX: --urgency=16

source /etc/profile.d/conda.sh
conda activate ecapa_tdnn
python3 trainRESNETModelMulti_ncl_1.py
conda deactivate
