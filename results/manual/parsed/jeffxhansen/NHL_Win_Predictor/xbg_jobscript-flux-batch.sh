#!/bin/bash
#FLUX: --job-name=conspicuous-peanut-butter-3879
#FLUX: -n=10
#FLUX: -t=36000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
mamba activate nhl_pred
python ~/NHL_Win_Predictor/xgboost_train.py
