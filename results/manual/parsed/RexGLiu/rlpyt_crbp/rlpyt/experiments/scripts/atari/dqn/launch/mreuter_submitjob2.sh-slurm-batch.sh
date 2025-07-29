#!/bin/bash
#FLUX: --job-name=r2d1
#FLUX: -n=4
#FLUX: --queue=gpu
#FLUX: -t=705600
#FLUX: --urgency=16

module load anaconda/3-5.2.0
module load cuda/10.1.105
module load gcc/5.4
module load ninja/1.9.0
source activate torch
python launch_atari_r2d1_gpu_breakout.py > mreuter_out2.txt
