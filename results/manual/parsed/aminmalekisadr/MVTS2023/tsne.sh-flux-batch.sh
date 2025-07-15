#!/bin/bash
#FLUX: --job-name="MVVGE-tsne"
#FLUX: --queue=gpu_p100
#FLUX: -t=604800
#FLUX: --priority=16

echo "Cuda device: $CUDA_VISIBLE_DEVICES"
echo "======= Start memory test ======="
python main.py experiments/Config.yaml SMD tsne
