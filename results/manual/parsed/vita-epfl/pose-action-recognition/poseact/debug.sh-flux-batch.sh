#!/bin/bash
#FLUX: --job-name=debug
#FLUX: -c=16
#FLUX: --queue=debug
#FLUX: -t=3600
#FLUX: --priority=16

echo started at `date`
module load gcc/8.4.0-cuda cuda/10.2.89
source /home/wexiong/anaconda3/bin/activate base 
conda activate pytorch 
echo "${@:1}"
python -u "${@:1}"
wait 
echo finished at `date`
