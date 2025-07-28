#!/bin/bash
#FLUX: --job-name=distance_estimation_dino
#FLUX: -c=8
#FLUX: --queue=boost_usr_prod
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load profile/deeplrn python
nvidia-smi
source ./venv/bin/activate
python main.py --model zhu \
 --backbone dino \
 --regressor simple_roi \
 --batch_size 4 --input_h_w 720 1280 \
 --accumulation_steps 1\
 --lr 5e-05 \
 --loss l1 \
 --test_sampling_stride 1\
 --train_sampling_stride 1\
 --ds_path /leonardo/home/usertrain/a08tra51/distance_estimation_project/data/MOTSynth \
 --annotations_path /leonardo/home/usertrain/a08tra51/distance_estimation_project/annotations_clean\
 --num_gpus 2 \
 --epochs 20 \
