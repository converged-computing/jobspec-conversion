#!/bin/bash
#FLUX: --job-name=UCR_PEMS-SF
#FLUX: -c=10
#FLUX: -t=72000
#FLUX: --urgency=16

module purge
module load pytorch-gpu/py3/1.7.0
set -x
python -u script_exp_dataset.py ../../../data/UCR_UEA/PEMS-SF.pickle 1000 3 8 0.8
