#!/bin/bash
#FLUX: --job-name=magic123
#FLUX: -t=10800
#FLUX: --urgency=16

module load gcc/7.5.0
source venv_magic123/bin/activate
which python 
nvidia-smi
nvcc --version
hostname
NUM_GPU_AVAILABLE=`nvidia-smi --query-gpu=name --format=csv,noheader | wc -l`
echo "number of gpus:" $NUM_GPU_AVAILABLE
RUN_ID=$2-p60 # jobname for the first stage
RUN_ID2=$3-p60 # jobname for the second stage
DATA_DIR=$4 # path to the directory containing the images, e.g. data/nerf4/chair
IMAGE_NAME=rgba.png # name of the image file, e.g. rgba.png
step1=$5 # whether to use the first stage
step2=$6 # whether to use the second stage
FILENAME=$(basename $DATA_DIR)
dataset=$(basename $(dirname $DATA_DIR))
echo reconstruct $FILENAME under dataset $dataset from folder $DATA_DIR ...
if (( ${step1} )); then
    CUDA_VISIBLE_DEVICES=$1 python main.py -O \
        --text "A high-resolution DSLR image of <token>" \
        --sd_version 1.5 \
        --image ${DATA_DIR}/${IMAGE_NAME} \
        --learned_embeds_path ${DATA_DIR}/learned_embeds.bin \
        --workspace out/magic123-${RUN_ID}-coarse/$dataset/magic123_${FILENAME}_${RUN_ID}_coarse \
        --optim adam \
        --iters 5000 \
        --guidance SD zero123 \
        --lambda_guidance 1.0 40 \
        --guidance_scale 100 5 \
        --latent_iter_ratio 0 \
        --normal_iter_ratio 0.2 \
        --t_range 0.2 0.6 \
        --bg_radius -1 \
        --radius_range 1.0 1.5 \
        --fovy_range 40 70 \
        --default_polar 60 \
        --save_mesh \
        ${@:7}
fi
if (( ${step2} )); then
    CUDA_VISIBLE_DEVICES=$1 python main.py -O \
        --text "A high-resolution DSLR image of <token>" \
        --sd_version 1.5 \
        --image ${DATA_DIR}/${IMAGE_NAME} \
        --learned_embeds_path ${DATA_DIR}/learned_embeds.bin \
        --workspace out/magic123-${RUN_ID}-${RUN_ID2}/$dataset/magic123_${FILENAME}_${RUN_ID}_${RUN_ID2} \
        --dmtet --init_ckpt out/magic123-${RUN_ID}-coarse/$dataset/magic123_${FILENAME}_${RUN_ID}_coarse/checkpoints/magic123_${FILENAME}_${RUN_ID}_coarse.pth \
        --iters 5000 \
        --optim adam \
        --latent_iter_ratio 0 \
        --guidance SD zero123 \
        --lambda_guidance 1e-3 0.01 \
        --guidance_scale 100 5 \
        --rm_edge \
        --bg_radius -1 \
        --radius_range 1.0 1.5 \
        --fovy_range 40 70 \
        --default_polar 60 \
        --save_mesh 
fi
