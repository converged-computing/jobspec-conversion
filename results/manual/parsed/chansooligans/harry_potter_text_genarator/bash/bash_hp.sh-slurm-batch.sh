#!/bin/bash
#FLUX: --job-name=hp_tr
#FLUX: -c=2
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
module load python3/intel/3.6.3
python3 harry_potter_train.py
