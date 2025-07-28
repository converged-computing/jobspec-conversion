#!/bin/bash
#FLUX: --job-name=training
#FLUX: -c=2
#FLUX: --urgency=16

echo "Submitted from:"$SLURM_SUBMIT_DIR" on node:"$SLURM_SUBMIT_HOST
echo "Running on node "$SLURM_JOB_NODELIST 
echo "Allocate Gpu Units:"$CUDA_VISIBLE_DEVICES
nvidia-smi
python slice_promise.py --source_dir='./data/promise' \
 --dest_dir='./data/promise_WSS' \
 --n_augment=0
python gen_weak.py --base_folder='./data/promise_WSS/train' \
 --save_subfolder='box20' \
 --strategy='box_strat' \
 --selected_class=1 \
 --filling 1 \
 --seed=0 \
 --margin=20 \
python gen_weak.py --base_folder='./data/promise_WSS/val' \
 --save_subfolder='box20' \
 --strategy='box_strat' \
 --selected_class=1 \
 --filling 1 \
 --seed=0 \
 --margin=0 \
