#!/bin/bash
#FLUX: --job-name=CS
#FLUX: -t=4800
#FLUX: --urgency=16

module load lang/python/miniconda/3.9.7
module load lang/gcc/9.3.0
source activate rnpe_env
python -m scripts.run_task --seed=$SLURM_ARRAY_TASK_ID --task-name="${SLURM_JOB_NAME}" --results-dir="/user/work/dw16200/project/misspecification/rnpe/results/${SLURM_JOB_NAME}"
