#!/bin/bash
#FLUX: --job-name=optuna_mlp_mixer
#FLUX: -c=8
#FLUX: --queue=koa
#FLUX: -t=1209600
#FLUX: --urgency=16

source ~/profiles/auto.profile
source activate pytorch
python hyperparameter_tuning.py
