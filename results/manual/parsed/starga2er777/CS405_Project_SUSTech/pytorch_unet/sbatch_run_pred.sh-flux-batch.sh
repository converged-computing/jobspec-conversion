#!/bin/bash
#FLUX: --job-name=test
#FLUX: --queue=gpulab02
#FLUX: --priority=16

nvidia-smi
python3 script_predict.py --datadir ../datasets/testimgs/ --num_gpu 1 --losstype segment
