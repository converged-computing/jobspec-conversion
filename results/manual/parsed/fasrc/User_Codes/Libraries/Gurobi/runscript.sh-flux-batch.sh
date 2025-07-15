#!/bin/bash
#FLUX: --job-name=swampy-punk-5240
#FLUX: --priority=16

module load python
module load gurobi
source activate gurobi_env
srun -c $SLURM_CPUS_PER_TASK python gurobi_test.py
