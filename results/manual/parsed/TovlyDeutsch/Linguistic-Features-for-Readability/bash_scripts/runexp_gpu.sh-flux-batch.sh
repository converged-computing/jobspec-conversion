#!/bin/bash
#FLUX: --job-name=dirty-mango-5928
#FLUX: --priority=16

echo ${RUN_CONFIG}
module load Anaconda3/5.0.1-fasrc02
module load cuda/10.0.130-fasrc01 cudnn/7.4.1.5_cuda10.0-fasrc01
source activate 2tf1.14_cuda10
python -W ignore runner.py -a ${SLURM_ARRAY_TASK_ID} ${RUN_CONFIG}
