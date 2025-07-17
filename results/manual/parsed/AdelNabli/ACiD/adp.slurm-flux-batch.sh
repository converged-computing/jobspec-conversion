#!/bin/bash
#FLUX: --job-name=distributed
#FLUX: -N=4
#FLUX: -c=8
#FLUX: -t=300
#FLUX: --urgency=16

module purge
module load cpuarch/amd
source /CONDADIR/miniconda3/etc/profile.d/conda.sh
conda activate ADP
set -x
srun python -u main.py \
                       --n_epoch_if_1_worker 300 \
                       --batch_size 128 \
                       --filter_bias_and_bn \
                       --lr 0.1 \
                       --dataset_name CIFAR10 \
                       --model_name resnet18 \
                       --use_linear_scaling \
                       --rate_com 1 \
                       --graph_topology exponential \
                       --apply_acid \
                       --weight_decay 0.0005 \
                       --normalize_grads
