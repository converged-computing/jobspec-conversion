#!/bin/bash
#FLUX: --job-name=frigid-staircase-4935
#FLUX: --queue=parallel
#FLUX: -t=86400
#FLUX: --urgency=16

module load gcc
module load mvapich2
module load python
source venv/updated-venv/bin/activate
cd robust_linear_regression
srun python optimal_experiments_Huber_decorrerlated_2.py
deactivate
