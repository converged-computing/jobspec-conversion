#!/bin/bash
#FLUX --job-name=moolicious-car-9465
#FLUX --queue=gpu20
#FLUX -t=21600
#FLUX --urgency=16

CUDA_VISIBLE_DEVICES=1 python ddp_train_nerf.py --config configs/EV3D/Bunny.txt
CUDA_VISIBLE_DEVICES=1 python ddp_test_nerf.py --config configs/EV3D/Bunny.txt --render_split train --testskip 1
echo Finished
