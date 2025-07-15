#!/bin/bash
#FLUX: --job-name=fn_adv
#FLUX: -c=24
#FLUX: --exclusive
#FLUX: -t=82800
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/usr/local/cuda/lib64:/share/apps/cudnn_8_1_0/cuda/lib64'

pwd; hostname; date
nvidia-smi
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/share/apps/cudnn_8_1_0/cuda/lib64
echo $LD_LIBRARY_PATH
REPO_LOC=/share/nas2/walml/repos/zoobot
/share/nas2/walml/miniconda3/envs/zoobot/bin/python /share/nas2/walml/repos/zoobot/zoobot/tensorflow/examples/finetune_advanced.py \
    --batch-size 512 \
    --epochs 50
