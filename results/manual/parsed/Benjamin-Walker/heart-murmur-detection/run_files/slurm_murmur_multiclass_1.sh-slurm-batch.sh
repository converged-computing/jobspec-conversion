#!/bin/bash
#FLUX: --job-name=murmul1
#FLUX: --queue=short
#FLUX: -t=43200
#FLUX: --urgency=16

module load Anaconda3
source activate /data/inet-multimodal-ai/wolf6245/envs/physionet22
conda info --env
python dbres.py --recalc_output --data_directory data/a_splits/cv_True_stratified_False/split_0/test_data --output_directory data/d_dbres_multiclass_outputs/cv_True_stratified_False/split_0 --model_binary_present_pth data/c_models/cv_True_stratified_False/split_0/model_BinaryPresent.pth --model_binary_unknown_pth data/c_models/cv_True_stratified_False/split_0/model_BinaryUnknown.pth
python dbres.py --recalc_output --data_directory data/a_splits/cv_True_stratified_False/split_1/test_data --output_directory data/d_dbres_multiclass_outputs/cv_True_stratified_False/split_1 --model_binary_present_pth data/c_models/cv_True_stratified_False/split_1/model_BinaryPresent.pth --model_binary_unknown_pth data/c_models/cv_True_stratified_False/split_1/model_BinaryUnknown.pth
python dbres.py --recalc_output --data_directory data/a_splits/cv_True_stratified_False/split_2/test_data --output_directory data/d_dbres_multiclass_outputs/cv_True_stratified_False/split_2 --model_binary_present_pth data/c_models/cv_True_stratified_False/split_2/model_BinaryPresent.pth --model_binary_unknown_pth data/c_models/cv_True_stratified_False/split_2/model_BinaryUnknown.pth
python dbres.py --recalc_output --data_directory data/a_splits/cv_True_stratified_False/split_3/test_data --output_directory data/d_dbres_multiclass_outputs/cv_True_stratified_False/split_3 --model_binary_present_pth data/c_models/cv_True_stratified_False/split_3/model_BinaryPresent.pth --model_binary_unknown_pth data/c_models/cv_True_stratified_False/split_3/model_BinaryUnknown.pth
python dbres.py --recalc_output --data_directory data/a_splits/cv_True_stratified_False/split_4/test_data --output_directory data/d_dbres_multiclass_outputs/cv_True_stratified_False/split_4 --model_binary_present_pth data/c_models/cv_True_stratified_False/split_4/model_BinaryPresent.pth --model_binary_unknown_pth data/c_models/cv_True_stratified_False/split_4/model_BinaryUnknown.pth
