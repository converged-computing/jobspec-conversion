#!/bin/bash
#FLUX: --job-name=wobbly-poodle-5119
#FLUX: -t=705600
#FLUX: --urgency=16

module load anaconda/3-5.2.0
module load cuda/10.1.105
module load gcc/5.4
module load ninja/1.9.0
source activate torch
python launch_atari_r2d1_async_alt_gravitar_v2.py > gravitar_out2.txt
