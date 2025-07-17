#!/bin/bash
#FLUX: --job-name=OpenFold2Train
#FLUX: -N=6
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

module load gpu/cuda-11.3
module load compilers/gcc-8.3.0
conda activate torch
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
srun python training.py \
-dataset_dir /gpfs/gpfs0/g.derevyanko/OpenFold2Dataset/Features \
-log_dir TrainLog \
-model_name model_small \
-num_gpus 4 \
-num_nodes 6 \
-num_accum 3 \
-max_iter 1500000 \
-precision bf16 \
-progress_bar 0 #\
