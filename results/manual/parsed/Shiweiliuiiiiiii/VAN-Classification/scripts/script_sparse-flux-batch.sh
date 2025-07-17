#!/bin/bash
#FLUX: --job-name=fugly-carrot-1545
#FLUX: -c=72
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=259140
#FLUX: --urgency=16

source /home/shiweil/miniconda3/etc/profile.d/conda.sh
source activate pt1.10_cuda11.3
module purge
module load 2021
module load CUDA/11.3.1
MODEL=van_tiny # van_{tiny, small, base, large}
DROP_PATH=0.1 # drop path rates [0.1, 0.1, 0.1, 0.2] for [tiny, small, base, large]
CUDA_VISIBLE_DEVICES=0,1,2,3 bash distributed_train2.sh 4 /scratch-shared/shiwei/  \
	   --model $MODEL -b 256 --lr 1e-3 --drop-path $DROP_PATH -j 72 -u 2000
source deactivate
