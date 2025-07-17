#!/bin/bash
#FLUX: --job-name=data_simulation
#FLUX: -t=1800
#FLUX: --urgency=16

export PYTHONPATH='/fred/oz149/Tyler/pyenv/$PYENV_NAME/lib/python3.7/site-packages:$PYTHONPATH'

NUMBER_OF_IMAGES=1000
RESOULTION=0.08
PYENV_NAME=deeplenstronomy
export PYTHONPATH=/fred/oz149/Tyler/pyenv/$PYENV_NAME/lib/python3.7/site-packages:$PYTHONPATH
source /fred/oz149/Tyler/pyenv/$PYENV_NAME/bin/activate
echo $PYTHONPATH
mkdir -p jobs/${SLURM_JOB_NAME}_${SLURM_JOB_ID}
OUT_DIR=jobs/${SLURM_JOB_NAME}_${SLURM_JOB_ID}
if [ ! -z "$SLURM_ARRAY_TASK_ID" ]; then
    mkdir -p jobs/${SLURM_JOB_NAME}_${SLURM_JOB_ID}/$SLURM_ARRAY_TASK_ID
    OUT_DIR=jobs/${SLURM_JOB_NAME}_${SLURM_JOB_ID}/$SLURM_ARRAY_TASK_ID
fi
SCRIPT_NAME="${SLURM_JOB_NAME}.sh"
echo "SCRIPT_NAME: $SCRIPT_NAME"
cp jobs/"$SCRIPT_NAME" $OUT_DIR
cp -r data/config_files $OUT_DIR
echo "Running data_simulation.py"
PYTHON_SCRIPT='src/data_simulation.py'
echo $((NUMBER_OF_IMAGES/SLURM_ARRAY_TASK_MAX)) images per job
cp "$PYTHON_SCRIPT" $OUT_DIR
python -u "$PYTHON_SCRIPT" $((NUMBER_OF_IMAGES/SLURM_ARRAY_TASK_MAX)) 0.08 $SLURM_JOB_ID $SLURM_ARRAY_TASK_ID
mv jobs/running/myjob-$SLURM_JOB_ID.out $OUT_DIR
mv jobs/running/myjob-$SLURM_JOB_ID.err $OUT_DIR
