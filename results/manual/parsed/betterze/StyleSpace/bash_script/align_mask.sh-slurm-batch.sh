#!/bin/bash
#SBATCH --output=./log/align_mask%A%a
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=20g
#SBATCH --time=1-00:00:00
#SBATCH --array=0-249%20

one=($(seq 0 4 996))
one_index=$((${SLURM_ARRAY_TASK_ID}%${#one[@]}))
python align_mask.py  -gradient_folder './npy/ffhq/gradient_mask_32' -semantic_path './npy/ffhq/semantic_mask.npy' -save_folder './npy/ffhq/align_mask_32'  -img_sindex ${one[$one_index]} -num_per 4
