#!/bin/bash
#FLUX: --job-name=misunderstood-bicycle-3613
#FLUX: --urgency=16

module load gcc/6.2.0
module load python/3.6.0
module load cuda/10.0
source ~/python_3.6.0/bin/activate
python ../scripts/TS04_tuning.py $1 $2 $3 $4
