#!/bin/bash
#FLUX: --job-name=bumfuzzled-lentil-9819
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
python TrainIvysaurus.py '3'
echo 'DONE'
