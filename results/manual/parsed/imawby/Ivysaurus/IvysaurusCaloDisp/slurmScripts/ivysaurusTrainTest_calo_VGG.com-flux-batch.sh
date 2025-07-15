#!/bin/bash
#FLUX: --job-name=grated-pedo-9629
#FLUX: -c=5
#FLUX: -t=21600
#FLUX: --priority=16

source /etc/profile
echo 'BEGIN'
echo Job running on compute node `uname -n`
cd /home/hpc/30/mawbyi1/Ivysaurus/IvysaurusCaloDisp/
module add cuda
module add anaconda3-gpu
source activate opence_env
python TrainIvysaurusCalo.py '0'
echo 'DONE'
