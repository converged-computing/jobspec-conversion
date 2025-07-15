#!/bin/bash
#FLUX: --job-name=model_training
#FLUX: -t=50400
#FLUX: --priority=16

export LD_LIBRARY_PATH='/fred/oz149/Tyler/pyenv/$PYENV_NAME/lib:${LD_LIBRARY_PATH}'
export PYTHONPATH='/fred/oz149/Tyler/pyenv/$PYENV_NAME/lib/python3.7/site-packages:${PYTHONPATH}'

module load cuda/11.7.0
module load gcc/11.3.0
module load openmpi/4.1.4
module load python/3.10.4
module load tensorflow/2.11.0-cuda-11.7.0
PYENV_NAME=tensorflow
export LD_LIBRARY_PATH=/fred/oz149/Tyler/pyenv/$PYENV_NAME/lib:${LD_LIBRARY_PATH}
export PYTHONPATH=/fred/oz149/Tyler/pyenv/$PYENV_NAME/lib/python3.7/site-packages:${PYTHONPATH}
source /fred/oz149/Tyler/pyenv/$PYENV_NAME/bin/activate
echo $PYTHONPATH
if [ ! -z "$SLURM_ARRAY_TASK_ID" ]; then
    mkdir -p jobs/${SLURM_JOB_NAME}_${SLURM_ARRAY_JOB_ID}/$SLURM_ARRAY_TASK_ID
    OUT_DIR=jobs/${SLURM_JOB_NAME}_${SLURM_ARRAY_JOB_ID}/$SLURM_ARRAY_TASK_ID
    JOB_NAME=${SLURM_JOB_NAME}_${SLURM_ARRAY_JOB_ID}
    OUT_FILE=myjob-${SLURM_JOB_ID}.out
    ERR_FILE=myjob-${SLURM_JOB_ID}.err
fi
if [ -z "$SLURM_ARRAY_TASK_ID" ]; then
    mkdir -p jobs/${SLURM_JOB_NAME}_${SLURM_JOB_ID}
    OUT_DIR=jobs/${SLURM_JOB_NAME}_${SLURM_JOB_ID}
    JOB_NAME=${SLURM_JOB_NAME}_${SLURM_ARRAY_JOB_ID}
    OUT_FILE=myjob-${SLURM_JOB_ID}.out
    ERR_FILE=myjob-${SLURM_JOB_ID}.err
fi
SCRIPT_NAME="${SLURM_JOB_NAME}.sh"
echo "SCRIPT_NAME: $SCRIPT_NAME"
cp jobs/"$SCRIPT_NAME" $OUT_DIR
echo "Running model_training.py"
PYTHON_SCRIPT='src/model_training.py'
DATASET_DIR="data/"
LEARNING_RATE=(0.001 0.0001 0.00001)
BATCH_SIZE=1024
LENS_MODEL="epl"
cp "$PYTHON_SCRIPT" $OUT_DIR
python -u "$PYTHON_SCRIPT" $DATASET_DIR ${LEARNING_RATE[$SLURM_ARRAY_TASK_ID]} $BATCH_SIZE $OUT_DIR $LENS_MODEL
mv jobs/running/$OUT_FILE $OUT_DIR
mv jobs/running/$ERR_FILE $OUT_DIR
