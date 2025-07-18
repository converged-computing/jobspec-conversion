#!/bin/bash
#FLUX: --job-name=sticky-kerfuffle-7727
#FLUX: -n=20
#FLUX: --urgency=16

source /etc/profile
source activate nerf_pl
python train_efficient_sm.py --dataset_name efficient_sm\
 --root_dir ../../datasets/variable_cam/results_500_v2_vase_sigma150/\
 --N_importance 128 --N_samples 64 --use_disp\
 --num_gpus 0 --img_wh 64 64 --noise_std 0 --num_epochs 300 --optimizer adam --lr 0.00001\
 --exp_name RAY_TERM_ONLY_VASE_SIGMA150_64x64_sm2_nimp128_nsamp64_run1 --num_sanity_val_steps 1\
 --Light_N_importance 128 --grad_on_light --batch_size 4096
python train_efficient_sm.py --dataset_name efficient_sm\
 --root_dir ../../datasets/variable_cam/statue_200_var_cam_v1_sigma150/\
 --N_importance 128 --N_samples 64\
 --num_gpus 0 --img_wh 64 64 --noise_std 0 --num_epochs 300 --optimizer adam --lr 0.00001\
 --exp_name statue_200_sigma150_64x64_sm2_nimp128_nsamp64_run1 --num_sanity_val_steps 1\
 --Light_N_importance 128 --grad_on_light --batch_size 4096
