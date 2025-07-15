#!/bin/bash
#FLUX: --job-name=evasive-dog-0698
#FLUX: --priority=16

module load python/3.6.1
module load cuda/11.2.0
module load py-pytorch/1.4.0_py36
module load py-numpy/1.19.2_py36
module load py-pandas/1.0.3_py36
python3 generation/estimate_lee.py
