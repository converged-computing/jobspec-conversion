#!/bin/bash
#FLUX: --job-name=prostate_calc
#FLUX: -N=4
#FLUX: --queue=gpu05,gpu
#FLUX: -t=72000
#FLUX: --urgency=16

module purge
module load utilities/multi
module load readline/7.0
module load gcc/10.2.0
module load cuda/11.5.0
module load python/anaconda/4.6/miniconda/3.7
echo ">>> Installing Requirements";
conda run -n custom_env pip install -r requirements.txt
echo ">>> Running Code";
/usr/bin/env time -v conda run -n custom_env python code3.py
