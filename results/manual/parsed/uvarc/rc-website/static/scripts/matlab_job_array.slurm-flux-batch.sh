#!/bin/bash
#FLUX: --job-name=runMultiple
#FLUX: -t=600
#FLUX: --urgency=16

export slurm_ID='${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}'
export numWorkers='$((SLURM_NTASKS-1))'

module purge
module load matlab
export slurm_ID="${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}"
export numWorkers=$((SLURM_NTASKS-1))
nLoops=400; # number of iterations to perform
nDim=400; # Dimension of matrix to create
matlab -nodisplay  -r \
"setPool1; pcalc2(${nLoops},${nDim},'${slurm_ID}');exit;"
