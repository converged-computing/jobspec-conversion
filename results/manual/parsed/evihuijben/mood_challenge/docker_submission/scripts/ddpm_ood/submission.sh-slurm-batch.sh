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
python ./reconstruct_mood_submission.py  --save_nifti --easy_detection --model_name 'mood_simplex_ddp_07_12'  --run_val 0 --run_in 0 --run_out 1
