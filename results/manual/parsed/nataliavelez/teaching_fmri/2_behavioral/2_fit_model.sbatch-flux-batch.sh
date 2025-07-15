#!/bin/bash
#FLUX: --job-name=bumfuzzled-chair-3033
#FLUX: --priority=16

module load ncf
module load Anaconda/5.0.1-fasrc01
source activate py3
if [[ $1 == 11 ]]; then
    echo "No free parameters; using deterministic method"
    python 2_fit_strong_model.py ${SLURM_ARRAY_TASK_ID}
else
    echo "Fitting model using scipy.optimize"
    python 2_fit_model.py ${SLURM_ARRAY_TASK_ID} $1
fi
