#!/bin/bash
#FLUX: --job-name=chunky-latke-5785
#FLUX: -c=5
#FLUX: --queue=astro
#FLUX: -t=21600
#FLUX: --urgency=16

source /etc/profile
echo 'BEGIN'
echo Job running on compute node `uname -n`
cd /home/hpc/30/mawbyi1/Ivysaurus
module add cuda
module add anaconda3-gpu
source activate opence_env
python TrainIvysaurus.py '1'
echo 'DONE'
