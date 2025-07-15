#!/bin/bash
#FLUX: --job-name=delicious-hobbit-1093
#FLUX: --queue=parallel
#FLUX: -t=86400
#FLUX: --priority=16

module load gcc
module load mvapich2
module load python
source venv/updated-venv/bin/activate
cd robust_linear_regression
srun python optimal_experiments_L2_decorrerlated_2.py
deactivate
