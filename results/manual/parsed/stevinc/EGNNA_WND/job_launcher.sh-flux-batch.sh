#!/bin/bash
#FLUX: --job-name=3Adj-EGNNA
#FLUX: --queue=prod
#FLUX: --urgency=16

export PYTHONPATH='${PYTHONPATH}:/homes/svincenzi/.conda/envs/py_env2/bin/python'

source activate py_env2
module load cuda/10.0
export PYTHONPATH="${PYTHONPATH}:/homes/svincenzi/.conda/envs/py_env2/bin/python"
srun python -u main.py --id_optim=${SLURM_ARRAY_TASK_ID}
