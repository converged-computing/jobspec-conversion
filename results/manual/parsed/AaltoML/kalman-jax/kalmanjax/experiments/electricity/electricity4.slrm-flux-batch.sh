#!/bin/bash
#FLUX: --job-name=ornery-truffle-1913
#FLUX: --priority=16

module load miniconda
source activate venv
srun python electricity.py 4 $SLURM_ARRAY_TASK_ID
