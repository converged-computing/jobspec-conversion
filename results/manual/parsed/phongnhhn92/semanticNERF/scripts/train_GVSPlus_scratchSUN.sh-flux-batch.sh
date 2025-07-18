#!/bin/bash
#FLUX: --job-name=PHONG
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

module load gcc/8.3.0 cuda/10.1.168 cudnn cmake
srun python ../train_GVSNETPlus.py --num_gpus 4 --dataset_name carlaGVS --root_dir /scratch/project_2001055/dataset/GVS \
  --log_dir /scratch/project_2001055/trained_logs/GVSPlus \
  --img_wh 256 256 --noise_std 0.1 --num_epochs 30 --batch_size 4 --num_rays 4096 --N_importance 32 \
  --optimizer adam --lr 5e-4 --lr_scheduler steplr --decay_step 10 25 --decay_gamma 0.5 \
  --use_disparity_loss --exp_name exp_GVSPlus_AlphaSampler_scratchSUN
