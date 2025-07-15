#!/bin/bash
#FLUX: --job-name=angry-fudge-5401
#FLUX: --urgency=16

module rm compiler/rocm/2.9
module load compiler/rocm/3.3
module load mathlib/opencv/3.1.0/gcc
conda create -n patchmatch python=3.7
source activate patchmatch
pip install -i https://mirrors.aliyun.com/pypi/simple/ -r requirements.txt
pip uninstall datasets
DTU_TESTING="/home/dtu/"
ETH3d_TESTING="/home/eth3d_high_res_test/"
TANK_TESTING="/home/TankandTemples/"
CUSTOM_TESTING="./data/scan2"
CKPT_FILE="./checkpoints/model_000007.ckpt"
python3 eval_custom.py --dataset=custom --batch_size=1 --n_views 5 \
--patchmatch_iteration 1 2 2 --patchmatch_range 6 4 2 \
--patchmatch_num_sample 8 8 16 --propagate_neighbors 0 8 16 --evaluate_neighbors 9 9 9 \
--patchmatch_interval_scale 0.005 0.0125 0.025 \
--testpath=$CUSTOM_TESTING --geo_pixel_thres=1 --geo_depth_thres=0.01 --photo_thres 0.8 \
--outdir ./outputs_custom --loadckpt $CKPT_FILE $@
source deactivate
