#!/bin/bash
#FLUX: --job-name=eiafcst
#FLUX: --queue=shared
#FLUX: -t=43200
#FLUX: --urgency=16

module purge
module load cuda/9.2.148
module load python/anaconda3
nvidia-smi
tid=$SLURM_ARRAY_TASK_ID
(( end = $tid * 3 ))
files=`head -$end filelist.txt | tail -3`
echo "Running files:"
echo $files
echo $files | xargs python gather_model_stats.py > diagnostic/gdp/rslts-summary$tid.csv
