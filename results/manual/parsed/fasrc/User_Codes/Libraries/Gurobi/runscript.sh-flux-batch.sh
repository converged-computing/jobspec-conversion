#!/bin/bash
#FLUX: --job-name=gurobitest
#FLUX: --queue=test
#FLUX: -t=30
#FLUX: --urgency=16

module load python
module load gurobi
source activate gurobi_env
srun -c $SLURM_CPUS_PER_TASK python gurobi_test.py
