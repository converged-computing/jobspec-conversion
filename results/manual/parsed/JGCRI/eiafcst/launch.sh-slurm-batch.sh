#!/bin/bash
#FLUX: --job-name=eiafcst
#FLUX: -n=8
#FLUX: --queue=shared
#FLUX: -t=43200
#FLUX: --urgency=16

module purge
module load cuda/9.2.148
module load python/anaconda3.2019.3
source /share/apps/python/anaconda3.2019.3/etc/profile.d/conda.sh
nvidia-smi
tid=$SLURM_ARRAY_TASK_ID
echo "python eiafcst/models/hpar_opt.py $1 $2 $3${tid}.csv"
python eiafcst/models/hpar_opt.py $1 $2 $3${tid}.csv
