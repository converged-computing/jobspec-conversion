#!/bin/bash
#FLUX: --job-name=centermask2_tissuenet_w_train_1C
#FLUX: --queue=tier3
#FLUX: -t=259200
#FLUX: --urgency=16

cd centermask2
spack load cuda@11.0.2%gcc@9.3.0/lrd2rcw
nvidia-smi
python train_net.py --config-file centermask2/benchmark_config/tissuenet_wholecell_train.yaml --num-gpus 4
