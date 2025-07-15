#!/bin/bash
#FLUX: --job-name=moolicious-mango-5187
#FLUX: --priority=16

source activate mlfold-test
python ./training.py \
           --path_for_outputs "./exp_020" \
           --path_for_training_data "path_to/pdb_2021aug02" \
           --num_examples_per_epoch 1000 \
           --save_model_every_n_epochs 50
