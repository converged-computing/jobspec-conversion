#!/bin/bash
#FLUX: --job-name=ofa_mini_video_vqa_ofa_mini_pretrain_bart_allresnet_inittext
#FLUX: -N=2
#FLUX: -n=2
#FLUX: --exclusive
#FLUX: -t=86400
#FLUX: --priority=16

cd /lus/home/NAT/gda2204/mshukor/code/ofa_ours/run_scripts
source /lus/home/NAT/gda2204/mshukor/.bashrc
conda activate main
rm core-python3*
srun -l -N 2 -n 2 -c 128 --gpus=16 bash vqa/video/ofa_mini_video_vqa_ofa_mini_pretrain_bart_allresnet_inittext.sh
