#!/bin/bash
#FLUX: --job-name=VGG_GNM
#FLUX: -t=18000
#FLUX: --urgency=16

module purge
module load applications-extra
module load cudnn/7.0.3-cuda9.0.176
module load anaconda/2.1.0
source activate base
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR
python main.py file -e $SLURM_ARRAY_TASK_ID
