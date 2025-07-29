#!/bin/bash
#FLUX: --job-name=peachy-destiny-4785
#FLUX: --queue=short
#FLUX: -t=86400
#FLUX: --urgency=16

module load miniconda
source activate venv
srun python electricity.py 4 $SLURM_ARRAY_TASK_ID
