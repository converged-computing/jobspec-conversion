#!/bin/bash
#FLUX: --job-name=viewfool-attack-hotdog
#FLUX: -n=16
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

cd ~/Neurips2023/ViewFool_
module load anaconda/latest
module load gcc/10.2
module load python/3.9.0
source activate base
python3 NeRF/ViewFool.py --dataset_name blender_for_attack --scene_name  'resnet_AP_lamba0.01/apple_2_hotdog' --img_wh 400 400 --N_importance 64 --ckpt_path './NeRF/ckpts/apple_2/epoch=29.ckpt' --optim_method NES --search_num 6 --popsize 51 --iteration 100 --mu_lamba 0.01 --sigma_lamba 0.01 --num_sample 100 --label_name 'Granny Smith' --label 948 --root_dir '/cifs/data/tserre/CLPS_Serre_Lab/projects/prj_video_imagenet/Gopal-ViewFool-Training/1.1hotdog/'
