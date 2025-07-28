#!/bin/bash
#FLUX: --job-name=MVVGE-mds
#FLUX: -n=4
#FLUX: -c=2
#FLUX: --queue=gpu_a100
#FLUX: -t=604800
#FLUX: --urgency=16

echo "Cuda device: $CUDA_VISIBLE_DEVICES"
echo "======= Start memory test ======="
python main.py experiments/Config.yaml SMD mds
