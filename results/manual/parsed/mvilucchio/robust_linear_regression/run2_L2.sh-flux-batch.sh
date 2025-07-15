#!/bin/bash
#FLUX: --job-name=reclusive-spoon-1151
#FLUX: --queue=parallel
#FLUX: -t=86400
#FLUX: --urgency=16

module load gcc
module load mvapich2
module load python
source venv/updated-venv/bin/activate
cd robust_linear_regression
srun python optimal_experiments_L2_decorrerlated_2.py
deactivate
