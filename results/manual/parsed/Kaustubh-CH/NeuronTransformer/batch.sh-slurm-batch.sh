#!/bin/bash
#FLUX: --job-name=DL4N_full_prod
#FLUX: --gpus-per-task=1
#FLUX: --queue=regular
#FLUX: -t=43200
#FLUX: --urgency=16

data_path=/pscratch/sd/k/ktub1999/bbp_May_18_8944917/
srun -n 1 shifter python3 Ntran2.py --data_path $data_path
