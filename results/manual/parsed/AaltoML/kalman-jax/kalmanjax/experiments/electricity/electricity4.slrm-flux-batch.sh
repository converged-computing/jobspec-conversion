#!/bin/bash
#FLUX: --job-name=evasive-ricecake-3776
#FLUX: --urgency=16

module load miniconda
source activate venv
srun python electricity.py 4 $SLURM_ARRAY_TASK_ID
