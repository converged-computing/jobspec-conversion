#!/bin/bash
#FLUX: --job-name=chocolate-diablo-1314
#FLUX: --queue=a800-9000
#FLUX: -t=600
#FLUX: --priority=16

export RANK_SIZE='1'

npu-smi info
export RANK_SIZE=1
python3 train_npu.py --epochs 10 --batch-size 64 --device_id 0
