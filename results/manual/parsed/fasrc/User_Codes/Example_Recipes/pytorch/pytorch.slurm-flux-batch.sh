#!/bin/bash
#FLUX: --job-name=loopy-staircase-5094
#FLUX: --queue=gpu
#FLUX: -t=30
#FLUX: --urgency=16

module load Anaconda3/5.0.1-fasrc02
module load cuda/10.0.130-fasrc01 cudnn/7.4.1.5_cuda10.0-fasrc01
source activate pytorch_3
python examples/mnist/main.py
