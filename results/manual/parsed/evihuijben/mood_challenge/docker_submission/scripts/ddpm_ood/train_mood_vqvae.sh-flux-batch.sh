#!/bin/bash
#FLUX: --job-name=mood_06_26
#FLUX: --queue=bme.gpuresearch.q
#FLUX: -t=540000
#FLUX: --urgency=16

module load cuda11.8/toolkit
python ./reconstruct_mood.py --modified --simplex_noise 1 --inference_name 'T100200300500' --inference_start 100 --output_dir  './checkpoints' --vqvae_checkpoint 'checkpoints/mood_vqvae_07_21/checkpoint.pth' --save_nifti --model_name 'mood_ldm_07_25'  --batch_size 1 --is_grayscale 1 --beta_schedule scaled_linear_beta --beta_start 0.0015 --beta_end 0.0195 --num_inference_steps 3 --inference_skip_factor 33 --run_val 1 --run_in 0 --run_out 0
