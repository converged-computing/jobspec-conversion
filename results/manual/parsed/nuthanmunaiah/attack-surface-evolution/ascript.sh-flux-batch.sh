#!/bin/bash
#FLUX: --job-name=stinky-animal-7213
#FLUX: --queue=work
#FLUX: --urgency=16

subject=$1
version=$2
offset=$3
parameters=$4
module load gcc/4.6.4
module load python/3.5.2
source venv/bin/activate
DEBUG=1 python3 manage.py analyzesensitivity \
    -s $subject \
    -r $version \
    -i $(($((offset*10000))+${SLURM_ARRAY_TASK_ID})) \
    -f $parameters
