#!/bin/bash
#FLUX: --job-name=CVHW1
#FLUX: -t=300
#FLUX: --priority=16

module purge
module load python/intel/3.8.6
cd /scratch/$USER/myjarraytest
python wordcount.py sample-$SLURM_ARRAY_TASK_ID.txt
