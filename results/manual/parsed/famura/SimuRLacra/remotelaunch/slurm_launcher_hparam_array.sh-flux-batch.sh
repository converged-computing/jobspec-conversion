#!/bin/bash
#FLUX: --job-name=hparam_array_cpu
#FLUX: -t=259200
#FLUX: --priority=16

echo "Starting Job $SLURM_JOB_ID, Array Job $SLURM_ARRAY_JOB_ID Index $SLURM_ARRAY_TASK_ID"
eval "$($HOME/Software/anaconda3/bin/conda shell.bash hook)"
conda activate pyrado
SIMURLACRA_DIR="$HOME/Software/SimuRLacra"
SCRIPTS_DIR="$SIMURLACRA_DIR/Pyrado/scripts"
cd "$SCRIPTS_DIR"
CMD="$@" # all arguments for the script call starting from PATHTO/SimuRLacra/Pyrado/scripts (excluding "python")
python $CMD --seed 1001 --ARG_NAME_FOR_THE_PARAM $SLURM_ARRAY_TASK_ID
