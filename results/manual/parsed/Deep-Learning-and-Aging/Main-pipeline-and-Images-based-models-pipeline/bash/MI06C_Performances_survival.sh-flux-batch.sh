#!/bin/bash
#FLUX: --job-name=hello-nalgas-7248
#FLUX: --queue=priority
#FLUX: --urgency=16

set -e
module load gcc/6.2.0
module load python/3.6.0
source /home/al311/python_3.6.0/bin/activate
python -u ../scripts/MI06C_Performances_survival.py $1 $2 $3 && echo "PYTHON SCRIPT COMPLETED"
