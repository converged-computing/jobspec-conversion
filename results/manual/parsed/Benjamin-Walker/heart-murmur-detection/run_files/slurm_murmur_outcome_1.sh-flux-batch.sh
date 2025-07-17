#!/bin/bash
#FLUX: --job-name=murout1
#FLUX: --queue=short
#FLUX: -t=43200
#FLUX: --urgency=16

module load Anaconda3
source activate /data/inet-multimodal-ai/wolf6245/envs/physionet22
conda info --env
python xgboost_integration.py --train_data_directory data/a_splits/cv_True_stratified_False/split_0/train_data --test_data_directory data/a_splits/cv_True_stratified_False/split_0/test_data --dbres_output_directory data/d_xgboost_OutcomeBinary_outputs/cv_True_stratified_False/split_0/dbres_output --model_binary_pth data/c_models/cv_True_stratified_False/split_0/model_OutcomeBinary.pth --output_directory data/xgboost_OutcomeBinary_outputs/cv_True_stratified_False/split_0
python xgboost_integration.py --train_data_directory data/a_splits/cv_True_stratified_False/split_1/train_data --test_data_directory data/a_splits/cv_True_stratified_False/split_1/test_data --dbres_output_directory data/d_xgboost_OutcomeBinary_outputs/cv_True_stratified_False/split_1/dbres_output --model_binary_pth data/c_models/cv_True_stratified_False/split_1/model_OutcomeBinary.pth --output_directory data/xgboost_OutcomeBinary_outputs/cv_True_stratified_False/split_1
python xgboost_integration.py --train_data_directory data/a_splits/cv_True_stratified_False/split_2/train_data --test_data_directory data/a_splits/cv_True_stratified_False/split_2/test_data --dbres_output_directory data/d_xgboost_OutcomeBinary_outputs/cv_True_stratified_False/split_2/dbres_output --model_binary_pth data/c_models/cv_True_stratified_False/split_2/model_OutcomeBinary.pth --output_directory data/xgboost_OutcomeBinary_outputs/cv_True_stratified_False/split_2
python xgboost_integration.py --train_data_directory data/a_splits/cv_True_stratified_False/split_3/train_data --test_data_directory data/a_splits/cv_True_stratified_False/split_3/test_data --dbres_output_directory data/d_xgboost_OutcomeBinary_outputs/cv_True_stratified_False/split_3/dbres_output --model_binary_pth data/c_models/cv_True_stratified_False/split_3/model_OutcomeBinary.pth --output_directory data/xgboost_OutcomeBinary_outputs/cv_True_stratified_False/split_3
python xgboost_integration.py --train_data_directory data/a_splits/cv_True_stratified_False/split_4/train_data --test_data_directory data/a_splits/cv_True_stratified_False/split_4/test_data --dbres_output_directory data/d_xgboost_OutcomeBinary_outputs/cv_True_stratified_False/split_4/dbres_output --model_binary_pth data/c_models/cv_True_stratified_False/split_4/model_OutcomeBinary.pth --output_directory data/xgboost_OutcomeBinary_outputs/cv_True_stratified_False/split_4
