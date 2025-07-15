#!/bin/bash
#FLUX: --job-name=model_exploration
#FLUX: -n=16
#FLUX: --queue=normal
#FLUX: -t=28800
#FLUX: --priority=16

RUNPATH=$HOME/projekte/mixed-precision-dnns
cd $RUNPATH
source $HOME/venvs/torch_exploration/bin/activate
python model_explorer/scripts/evaluate_individual.py workloads/resnet50.yaml dummy --progress -n 20
