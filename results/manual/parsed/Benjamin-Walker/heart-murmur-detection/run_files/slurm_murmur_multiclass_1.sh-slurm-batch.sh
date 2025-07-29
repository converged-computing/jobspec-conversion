#!/bin/bash
#SBATCH --job-name=murmul1
#SBATCH --mail-user=felix.krones@oii.ox.ac.uk
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=180G
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=28,gpu_mem:32GB

module load Anaconda3
source activate /data/inet-multimodal-ai/wolf6245/envs/physionet22
conda info --env
python dbres.py --recalc_output --data_directory data/a_splits/cv_True_stratified_False/split_0/test_data --output_directory data/d_dbres_multiclass_outputs/cv_True_stratified_False/split_0 --model_binary_present_pth data/c_models/cv_True_stratified_False/split_0/model_BinaryPresent.pth --model_binary_unknown_pth data/c_models/cv_True_stratified_False/split_0/model_BinaryUnknown.pth
python dbres.py --recalc_output --data_directory data/a_splits/cv_True_stratified_False/split_1/test_data --output_directory data/d_dbres_multiclass_outputs/cv_True_stratified_False/split_1 --model_binary_present_pth data/c_models/cv_True_stratified_False/split_1/model_BinaryPresent.pth --model_binary_unknown_pth data/c_models/cv_True_stratified_False/split_1/model_BinaryUnknown.pth
python dbres.py --recalc_output --data_directory data/a_splits/cv_True_stratified_False/split_2/test_data --output_directory data/d_dbres_multiclass_outputs/cv_True_stratified_False/split_2 --model_binary_present_pth data/c_models/cv_True_stratified_False/split_2/model_BinaryPresent.pth --model_binary_unknown_pth data/c_models/cv_True_stratified_False/split_2/model_BinaryUnknown.pth
python dbres.py --recalc_output --data_directory data/a_splits/cv_True_stratified_False/split_3/test_data --output_directory data/d_dbres_multiclass_outputs/cv_True_stratified_False/split_3 --model_binary_present_pth data/c_models/cv_True_stratified_False/split_3/model_BinaryPresent.pth --model_binary_unknown_pth data/c_models/cv_True_stratified_False/split_3/model_BinaryUnknown.pth
python dbres.py --recalc_output --data_directory data/a_splits/cv_True_stratified_False/split_4/test_data --output_directory data/d_dbres_multiclass_outputs/cv_True_stratified_False/split_4 --model_binary_present_pth data/c_models/cv_True_stratified_False/split_4/model_BinaryPresent.pth --model_binary_unknown_pth data/c_models/cv_True_stratified_False/split_4/model_BinaryUnknown.pth
