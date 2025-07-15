#!/bin/bash
#FLUX: --job-name=data_augmentation
#FLUX: -t=18000
#FLUX: --priority=16

module load intel/python/3/2019.4.088
module load nvidia/cudasdk/11.6
source /home/mla_group_02/visa/bin/activate
python /home/mla_group_02/visa/VISA/src/data_augmentation/main_crop.py
