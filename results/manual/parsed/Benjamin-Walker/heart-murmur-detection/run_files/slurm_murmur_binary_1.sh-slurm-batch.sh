#!/bin/bash
#FLUX: --job-name=murbin1
#FLUX: --queue=short
#FLUX: -t=43200
#FLUX: --urgency=16

module load Anaconda3
source activate /data/inet-multimodal-ai/wolf6245/envs/physionet22
conda info --env
python dbres.py --recalc_output --data_directory data/a_splits/cv_True_stratified_False/split_0/test_data --output_directory data/d_dbres_MurmurBinary_outputs/cv_True_stratified_False/split_0 --model_binary_pth data/c_models/cv_True_stratified_False/split_0/model_MurmurBinary.pth
python xgboost_integration.py --train_data_directory data/a_splits/cv_True_stratified_False/split_0/train_data --test_data_directory data/a_splits/cv_True_stratified_False/split_0/test_data --dbres_output_directory data/d_xgboost_MurmurBinary_outputs/cv_True_stratified_False/split_0/dbres_output --model_binary_pth data/c_models/cv_True_stratified_False/split_0/model_MurmurBinary.pth --output_directory data/d_xgboost_MurmurBinary_outputs/cv_True_stratified_False/split_0
