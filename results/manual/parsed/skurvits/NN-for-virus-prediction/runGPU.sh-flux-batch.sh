#!/bin/bash
#FLUX: --job-name=gen-net-job
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0'
export LD_LIBRARY_PATH='/storage/software/python/3.6.3/CUDA-9.0/pkgs/cudatoolkit-9.0-h13b8566_0/lib/:$LD_LIBRARY_PATH'

module load python/3.6.3/CUDA-9.0
export CUDA_VISIBLE_DEVICES=0
export LD_LIBRARY_PATH=/storage/software/python/3.6.3/CUDA-9.0/pkgs/cudnn-7.1.2-cuda9.0_0/lib/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/storage/software/python/3.6.3/CUDA-9.0/pkgs/cudatoolkit-9.0-h13b8566_0/lib/:$LD_LIBRARY_PATH
python frequency_branch.py ./out/freq_test \
	--input_path ./data/DNA_data/fullset  \
	--epochs 3 \
	--filter_size 8 \
	--layer_sizes 1000 \
	--dropout 0.1 \
	--learning_rate 0.001 \
	--lr_decay None
