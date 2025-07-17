#!/bin/bash
#FLUX: --job-name=bricky-bike-5745
#FLUX: -c=5
#FLUX: --queue=astro
#FLUX: -t=28800
#FLUX: --urgency=16

source /etc/profile
echo 'BEGIN'
echo Job running on compute node `uname -n`
cd /home/hpc/30/mawbyi1/Ivysaurus
module add cuda
module add anaconda3-gpu
source activate opence_env
python TrainIvysaurus.py '4'
echo 'DONE'
