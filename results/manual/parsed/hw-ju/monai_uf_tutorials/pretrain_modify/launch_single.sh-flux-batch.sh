#!/bin/bash
#FLUX: --job-name=rainbow-lemur-3007
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=14400
#FLUX: --urgency=16

date;hostname;pwd
module load singularity
singularity exec --nv \
--bind /blue/vendor-nvidia/hju/data/swinunetr_pretrain_CT:/mnt \
/blue/vendor-nvidia/hju/monaicore0.9.1 \
python main.py \
--roi_x=128 --roi_y=128 --roi_z=128 \
--lrdecay --lr=6e-6 \
--batch_size=1 \
--epochs=3 --num_steps=6 --eval_num=2 \
--noamp
