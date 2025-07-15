#!/bin/bash
#FLUX: --job-name=butterscotch-plant-2079
#FLUX: --priority=16

CUDA_VISIBLE_DEVICES=1 python ddp_train_nerf.py --config configs/EV3D/Bunny.txt
CUDA_VISIBLE_DEVICES=1 python ddp_test_nerf.py --config configs/EV3D/Bunny.txt --render_split train --testskip 1
echo Finished
