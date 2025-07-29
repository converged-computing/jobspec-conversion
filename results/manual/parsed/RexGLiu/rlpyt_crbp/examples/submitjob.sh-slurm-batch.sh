#!/bin/bash
#FLUX: --job-name=gpu_breakout
#FLUX: -n=16
#FLUX: --queue=gpu
#FLUX: -t=705600
#FLUX: --urgency=16

module load anaconda/3-5.2.0
module load cuda/10.1.105
module load gcc/5.4
module load ninja/1.9.0
source activate torch
python breakout_example_7.py > out.txt
