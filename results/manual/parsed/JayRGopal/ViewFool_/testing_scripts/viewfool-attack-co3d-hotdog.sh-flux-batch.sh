#!/bin/bash
#FLUX: --job-name=hello-frito-9686
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --priority=16

cd ~/Neurips2023/ViewFool_
module load anaconda/latest
module load gcc/10.2
module load python/3.9.0
source activate base
python3 NeRF/ViewFool.py --dataset_name blender_for_attack --scene_name  'resnet_AP_lamba0.01/apple_perfception_hotdog' --img_wh 400 400 --N_importance 64 --ckpt_path '/cifs/data/tserre/CLPS_Serre_Lab/projects/prj_video_imagenet/PeRFception/PeRFception-v1-3/72/plenoxel_co3d_110_13060_23672/last.ckpt' --optim_method NES --search_num 6 --popsize 51 --iteration 100 --mu_lamba 0.01 --sigma_lamba 0.01 --num_sample 100 --label_name 'Granny Smith' --label 948 --root_dir '/cifs/data/tserre/CLPS_Serre_Lab/projects/prj_video_imagenet/Gopal-ViewFool-Training/1.1hotdog/'
