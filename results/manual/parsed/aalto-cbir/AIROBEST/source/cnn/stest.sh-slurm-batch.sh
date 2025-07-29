#!/bin/bash
#FLUX: --job-name=test
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

id -a
module purge
module load pytorch
module list
python -u test.py
echo -e "\n ... printing job stats .... \n"
used_slurm_resources.bash
