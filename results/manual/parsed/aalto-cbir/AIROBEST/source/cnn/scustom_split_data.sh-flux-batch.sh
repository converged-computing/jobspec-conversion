#!/bin/bash
#FLUX: --job-name=bumfuzzled-butter-0999
#FLUX: --priority=16

id -a
module purge
module load pytorch
module list
python -u custom_split_data.py
echo -e "\n ... printing job stats .... \n"
used_slurm_resources.bash
