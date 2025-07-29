#!/bin/bash
#FLUX: --job-name=train_dl_model
#FLUX: -c=4
#FLUX: -t=10800
#FLUX: --urgency=16

echo Job $SLURM_JOB_ID released
echo Load modules
module load gcc/9.3.0 arrow python scipy-stack cuda cudnn
echo Create virtual environemnt
virtualenv --no-download $SLURM_TMPDIR/venv
source $SLURM_TMPDIR/venv/bin/activate
echo Install packages
pip install --no-index --upgrade pip
pip install tensorflow
pip install scikit-learn
pip install ewstools
pip install matplotlib
pip install kaleido
echo Begin python job
python -u dl_train.py --num_epochs 200 --model 2
