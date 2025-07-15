#!/bin/bash
#FLUX: --job-name=ofa_mini_audio_caption_stage_1_ofa_mini_pretrain_bart_allresnet_ep10
#FLUX: --exclusive
#FLUX: -t=3600
#FLUX: --urgency=16

cd /lus/home/NAT/gda2204/mshukor/code/ofa_ours/run_scripts
source /lus/home/NAT/gda2204/mshukor/.bashrc
conda activate main
rm core-python3*
srun -l -N 1 -n 1 -c 128 --gpus=8 bash caption/audio/ofa_mini_audio_caption_stage_1_ofa_mini_pretrain_bart_allresnet_ep10.sh
