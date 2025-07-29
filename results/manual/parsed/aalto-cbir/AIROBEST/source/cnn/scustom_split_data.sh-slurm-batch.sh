#!/bin/bash
#FLUX: --job-name=create_full_dataset
#FLUX: --queue=gpu
#FLUX: -t=43200
#FLUX: --urgency=16

id -a
module purge
module load pytorch
module list
python -u custom_split_data.py
echo -e "\n ... printing job stats .... \n"
used_slurm_resources.bash
