#!/bin/bash
#FLUX: --job-name=purple-malarkey-6644
#FLUX: -t=3600
#FLUX: --urgency=16

echo "Starting task $SLURM_ARRAY_TASK_ID"
DIR=$(sed -n "${SLURM_ARRAY_TASK_ID}p" input_zip_files)
module load scipy-stack/2019b
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip
pip install --no-index tensorflow_cpu
pip install --no-index scikit_learn
python encoder_predict.py $DIR
