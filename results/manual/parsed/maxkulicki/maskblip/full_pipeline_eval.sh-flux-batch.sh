#!/bin/bash
#FLUX: --job-name=eccentric-parsnip-9810
#FLUX: -c=18
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --priority=16

module load 2022
module load Python/3.10.4-GCCcore-11.3.0
module load PyTorch/1.12.0-foss-2022a-CUDA-11.7.0
conda activate maskblip
cd maskblip
python evaluate_xdecoder.py
cp "$TMPDIR"/mIoU_hist.png $HOME
