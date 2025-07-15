#!/bin/bash
#FLUX: --job-name=carnivorous-house-7316
#FLUX: --urgency=16

id -a
module purge
module load pytorch
module list
python -u custom_split_data.py
echo -e "\n ... printing job stats .... \n"
used_slurm_resources.bash
