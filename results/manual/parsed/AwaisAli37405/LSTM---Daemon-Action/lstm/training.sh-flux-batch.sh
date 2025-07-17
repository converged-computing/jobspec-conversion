#!/bin/bash
#FLUX: --job-name=special_permitl
#FLUX: -c=2
#FLUX: --queue=amd
#FLUX: -t=691200
#FLUX: --urgency=16

module load any/python/3.8.3-conda
conda activate lstm-caise23
declare -a commands=(
"python ./dg_training.py -f PermitLog_filtered_preprocessed.csv -m lstm -e 50 -o rand_hpc" 
)
${commands[$SLURM_ARRAY_TASK_ID]}
