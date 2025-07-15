#!/bin/bash
#FLUX: --job-name=fat-spoon-0400
#FLUX: -t=14400
#FLUX: --urgency=16

echo "Loading modules"
module use /cm/shared/ex3-modules/latest/modulefiles
module load slurm/20.02.7
module load tensorflow2-py37-cuda10.2-gcc8/2.5.0
python --version
srun python cv_model_selection.py $SLURM_ARRAY_TASK_ID
