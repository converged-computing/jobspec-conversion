#!/bin/bash
#SBATCH --job-name=murbin1
#SBATCH --mail-user=felix.krones@oii.ox.ac.uk
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=180G
#SBATCH --time=12:00:00
#SBATCH --partition=short
#SBATCH --constraint=ntasks-per-node=28,gpu_mem:32GB

module load Anaconda3
source activate /data/inet-multimodal-ai/wolf6245/envs/physionet22
conda info --env
python dbres.py --recalc_output --data_directory data/a_splits/cv_True_stratified_False/split_0/test_data --output_directory data/d_dbres_MurmurBinary_outputs/cv_True_stratified_False/split_0 --model_binary_pth data/c_models/cv_True_stratified_False/split_0/model_MurmurBinary.pth
python xgboost_integration.py --train_data_directory data/a_splits/cv_True_stratified_False/split_0/train_data --test_data_directory data/a_splits/cv_True_stratified_False/split_0/test_data --dbres_output_directory data/d_xgboost_MurmurBinary_outputs/cv_True_stratified_False/split_0/dbres_output --model_binary_pth data/c_models/cv_True_stratified_False/split_0/model_MurmurBinary.pth --output_directory data/d_xgboost_MurmurBinary_outputs/cv_True_stratified_False/split_0
