#!/bin/bash
#FLUX: --job-name=rainbow-cherry-4116
#FLUX: --urgency=16

CUDA_VISIBLE_DEVICES=0
python oligo_designer_toolsuite_ai_filters/hybridization_probability/train_model.py -c configs/hybridization_probability/train_LSTM.yaml  
