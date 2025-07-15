#!/bin/bash
#FLUX: --job-name=frigid-lamp-2584
#FLUX: --urgency=16

cd /fs/cfar-projects/anim_inb
source env3-9-5/bin/activate
module unload cuda
module load cuda/11.3.1 cudnn/v8.2.1 ffmpeg gcc
python train_anime_sequence_2_stream.py configs/seg_config/config_final_seq_JamesBaxterThumper.py
