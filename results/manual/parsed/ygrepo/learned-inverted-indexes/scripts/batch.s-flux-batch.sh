#!/bin/bash
#FLUX: --job-name=yg390
#FLUX: -c=4
#FLUX: -t=7200
#FLUX: --priority=16

module purge
module load python3/intel/3.6.3
source ~/distiller/env/bin/activate
python3 src/many_lstms_main.py
