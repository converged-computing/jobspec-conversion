#!/bin/bash
#SBATCH --job-name=TEST
#SBATCH --output=TEST_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:2
#SBATCH --mem=64000M
#SBATCH --time=04:00:00
#SBATCH --partition=gpu_titanrtx_shared_course

module purge
module load 2021
module load Anaconda3/2021.05
source activate rs
python ./T-DiffRec/inference.py --data_path ./datasets/ --dataset=yelp_clean --cuda --gpu=1 # DONE # Cant be run on yelp noisy!
python ./L-DiffRec/inference.py --data_path ./datasets/ --dataset=yelp_noisy --cuda --gpu=1 --sampling_steps 0 --steps 100 # DONE, but paras modified; Cant be run on yelp noisy!
python ./LT-DiffRec/inference.py --data_path ./datasets/ --dataset=yelp_clean --cuda --gpu=1 --sampling_steps 0 --steps 100 # DONE, but paras modified
conda deactivate
