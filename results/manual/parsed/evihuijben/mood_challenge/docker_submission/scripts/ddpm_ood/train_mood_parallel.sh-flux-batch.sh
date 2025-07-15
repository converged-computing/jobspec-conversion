#!/bin/bash
#FLUX: --job-name=mood_07_11_p
#FLUX: --queue=bme.gpuresearch.q
#FLUX: -t=720000
#FLUX: --urgency=16

module load cuda11.8/toolkit
torchrun --nproc_per_node 4 --nnodes 1 train_ddpm_mood.py --simplex_noise 1 --parallel --data_dir '/home/bme001/shared/mood/abdom_train/abdom_train_resampled' --data_dir_val '/home/bme001/shared/mood/abdom_val/abdom_val_resampled' --batch_size 4 --model_name 'mood_simplex_ddp_abdom_08_23' --eval_freq 10 --checkpoint_every 10 --is_grayscale 1 --n_epochs 100 --beta_schedule 'scaled_linear_beta'  --beta_start 0.0015 --beta_end 0.0195
