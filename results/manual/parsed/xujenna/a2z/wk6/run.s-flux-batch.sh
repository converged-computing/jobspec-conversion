#!/bin/bash
#FLUX: --job-name=ted_talks2
#FLUX: -t=18000
#FLUX: --urgency=16

module purge
module load numpy/python3.6/intel/1.14.0 tensorflow/python3.6/1.5.0
cd /scratch/jx603/training-lstm-master
python train.py --data_dir=./data \
--rnn_size 2048 \
--num_layers 2 \
--seq_length 128 \
--batch_size 128 \
--num_epochs 50 \
--save_checkpoints ./checkpoints \
--save_model ./models
