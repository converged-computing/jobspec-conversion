#!/bin/bash
#FLUX: --job-name=florence_ncf
#FLUX: --queue=standard
#FLUX: -t=14400
#FLUX: --priority=16

module load python3.9-anaconda
source activate eqcorrscan
srun python3 florence_ncf.py $SLURM_ARRAY_TASK_ID
