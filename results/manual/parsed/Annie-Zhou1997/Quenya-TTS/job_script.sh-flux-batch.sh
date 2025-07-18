#!/bin/bash
#FLUX: --job-name=angry-buttface-1426
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --urgency=16

source $HOME/venvs/pf/bin/activate
module load eSpeak-NG/1.51-GCC-11.3.0
python3 run_training_pipeline.py quenya --gpu_id 0 --finetune --resume_checkpoint /scratch/s5480698/Quenya-TTS/Models/English/80k.pt
