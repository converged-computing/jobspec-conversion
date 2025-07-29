#!/bin/bash
#SBATCH --job-name=mood_06_26
#SBATCH --output=./log/output_%A_Training.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=4-04:00:00
#SBATCH --nodelist=bme-gpuB001

module load cuda11.8/toolkit
python ./reconstruct_mood.py --modified --simplex_noise 1 --inference_name 'T200' --inference_start 200 --out_data_dir '/home/bme001/shared/mood/abdom_toy/toy_resampled' --output_dir  './checkpoints' --save_nifti --model_name 'mood_simplex_ddp_abdom_08_23' --batch_size 1 --is_grayscale 1 --beta_schedule scaled_linear_beta --beta_start 0.0015 --beta_end 0.0195 --num_inference_steps 3 --inference_skip_factor 33 --run_val 0 --run_in 0 --run_out 1
