#!/bin/bash
#FLUX: --job-name=unet
#FLUX: --queue=cuda
#FLUX: -t=432000
#FLUX: --urgency=16

module load intel/python/3/2019.4.088
module load nvidia/cudasdk/11.6
source /home/mla_group_02/visa/bin/activate
python /home/mla_group_02/visa/VISA/src/unet/main.py
