#!/bin/bash
#FLUX: --job-name=eccentric-earthworm-4206
#FLUX: --queue=gpu8_long
#FLUX: -t=478800
#FLUX: --urgency=16

module load matlab/
module load anaconda3/cpu/5.2.0
module load cuda90/toolkit/9.1.176
module load cuda90/fft/9.1.176
cd /scratch/td2201/
python ml_is_good.py
