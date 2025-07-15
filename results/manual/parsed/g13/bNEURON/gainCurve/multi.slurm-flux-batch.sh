#!/bin/bash
#FLUX: --job-name=multi
#FLUX: -c=7
#FLUX: -t=86400
#FLUX: --priority=16

module purge
module load python
module load gcc
module load boost
module load matlab
module load anaconda
set -e
date
source activate py2
echo $nMethod
method=$(($SLURM_ARRAY_TASK_ID-1))
if [ $SLURM_ARRAY_TASK_ID == $nMethod ]; then
    ./multi -d $method --tIn=1
    echo "output tIncome with method $method"
else
    ./multi -d $method
fi
date
hostname
