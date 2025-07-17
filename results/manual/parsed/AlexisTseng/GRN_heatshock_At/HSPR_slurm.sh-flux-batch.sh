#!/bin/bash
#FLUX: --job-name=hsGRN_Gillespie
#FLUX: -c=10
#FLUX: --queue=icelake
#FLUX: -t=43200
#FLUX: --urgency=16

. /etc/profile.d/modules.sh # Leave this line (enables the module command)
module purge  # Removes all modules still loaded
source /home/jz531/.bashrc # need to source before conda activate
conda activate model_GRN
CMD="python3 HSPR_AZ_hpc.py -nit 5 -ids "159.461275414781" -psd 0 -hsd 1 -tsp 600 -hss 400"
eval $CMD
