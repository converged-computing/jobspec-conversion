#!/bin/bash
#FLUX: --job-name=av
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/home/wang9/.conda/envs/torch_env/lib/'

source activate torch_env
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/wang9/.conda/envs/torch_env/lib/
python train.py --features_path '../create_data/features_data/' --model_type 'audio_video'
