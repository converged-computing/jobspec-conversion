#!/bin/bash
#FLUX: --job-name=delicious-cupcake-6300
#FLUX: --queue=athey
#FLUX: -t=28800
#FLUX: --urgency=16

module load python/3.6.1
module load cuda/11.2.0
module load py-pytorch/1.4.0_py36
module load py-numpy/1.19.2_py36
module load py-pandas/1.0.3_py36
python3 generation/estimate_mats.py
