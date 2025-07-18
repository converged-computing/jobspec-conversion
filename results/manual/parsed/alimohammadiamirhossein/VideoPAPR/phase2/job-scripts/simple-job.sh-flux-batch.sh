#!/bin/bash
#FLUX: --job-name=milky-butter-5316
#FLUX: -t=30600
#FLUX: --urgency=16

cd ~/$projects/papr
module load StdEnv/2020
module load python/3.9
module load gcc/9.3.0
module load opencv/4.5.5
module load rust/1.53.0
source ~/py_papr/bin/activate
date
python train1.py
