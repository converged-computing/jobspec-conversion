#!/bin/bash
#FLUX: --job-name=hairy-plant-3895
#FLUX: -c=5
#FLUX: --queue=astro
#FLUX: -t=21600
#FLUX: --urgency=16

source /etc/profile
echo 'BEGIN'
echo Job running on compute node `uname -n`
cd /home/hpc/30/mawbyi1/Ivysaurus/IvysaurusCaloDisp/
module add cuda
module add anaconda3-gpu
source activate opence_env
python TrainIvysaurus.py
echo 'DONE'
