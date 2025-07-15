#!/bin/bash
#FLUX: --job-name=wobbly-motorcycle-3417
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

export PYTHONPATH='../venv-torch/lib64/python3.7/site-packages:$PYTHONPATH'

LR=$1
module purge
module load pytorch/1.3.0
PROJDIR=$HOME/proj_deepsequence/scratch/ginter/cafa
source $PROJDIR/venv-torch/bin/activate
export PYTHONPATH=../venv-torch/lib64/python3.7/site-packages:$PYTHONPATH
python3 train.py --train CAFA4-ctrl/train.torchbin --dev CAFA4-ctrl/devel.torchbin --max-labels 5000 --class-stats-file CAFA4-ctrl/class-stats.json --store-cpoint fix-norank-checkpoint-CAFA4-ctrl.$LR --lrate $LR --report-every 1000
