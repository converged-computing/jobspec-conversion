#!/bin/bash
#FLUX: --job-name=expensive-pot-3325
#FLUX: -t=259200
#FLUX: --priority=16

cd centermask2
spack load cuda@11.0.2%gcc@9.3.0/lrd2rcw
nvidia-smi
python train_net.py --config-file centermask2/benchmark_config/tissuenet_nuclear_train.yaml --num-gpus 4
