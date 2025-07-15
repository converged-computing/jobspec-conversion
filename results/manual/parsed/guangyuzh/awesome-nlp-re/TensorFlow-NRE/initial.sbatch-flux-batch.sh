#!/bin/bash
#FLUX: --job-name=Init_data
#FLUX: -c=20
#FLUX: -t=172800
#FLUX: --priority=16

module purge
module load python3/intel/3.5.3
python3 -u initial.py > logs/Init_data.log
