#!/bin/bash
#FLUX: --job-name=crafter
#FLUX: -t=259200
#FLUX: --urgency=16

export IMAGEIO_FFMPEG_EXE='/home/mila/c/chris.emezue/scratch/ffmpeg-git-20220910-amd64-static/ffmpeg'

module load python/3
source /home/mila/c/chris.emezue/scratch/crafter-env/bin/activate
module load cudatoolkit/11.3
export IMAGEIO_FFMPEG_EXE=/home/mila/c/chris.emezue/scratch/ffmpeg-git-20220910-amd64-static/ffmpeg
python3 main.py \
 --profile=oc_ca \
 --logger.type wandb \
 --wandb_entity world-models-rl \
 --wandb_tag crf_144 \
 --save_folder_for_attn_maps /home/mila/c/chris.emezue/scratch/crafter-attn \
 --crf.size 144
