#!/bin/bash
#FLUX: --job-name=demo
#FLUX: --queue=spgpu
#FLUX: -t=28800
#FLUX: --priority=16

/bin/hostname
nvidia-smi
python3 /home/apalakod/eecs_592_project/models/climate_denial_downstream.py --pretrained_model_path='/home/apalakod/eecs_592_project/zip_gg_files/fine-tuned_models/base' --model_name='base' --data_path='/home/apalakod/eecs_592_project/data/climate_sentiment_train.csv' --test_data_path='/home/apalakod/eecs_592_project/data/climate_sentiment_test.csv' --mode='test-base'
