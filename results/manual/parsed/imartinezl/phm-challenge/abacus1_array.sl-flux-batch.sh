#!/bin/bash
#FLUX: --job-name=red-poodle-1779
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=1209600
#FLUX: --urgency=16

module load Miniconda3/4.9.2
module load CUDA/10.2.89-GCC-8.3.0 # for CPAB
source activate .venv
CASE_NUM=`printf %03d $SLURM_ARRAY_TASK_ID`
cd runs
srun bash run$CASE_NUM.sh
