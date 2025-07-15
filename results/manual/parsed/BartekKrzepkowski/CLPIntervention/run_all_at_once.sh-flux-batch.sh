#!/bin/bash
#FLUX: --job-name=eff
#FLUX: -c=12
#FLUX: --queue=plgrid-gpu-a100
#FLUX: -t=43200
#FLUX: --priority=16

eval "$(conda shell.bash hook)"
conda activate clpi_env
source src/configs/env_variables.sh
WANDB__SERVICE_WAIT=300 python -m scripts.python_new.run_all_at_once model_name=mm_resnet dataset_name=mm_cifar10 lr=5e-1 wd=0.0 phase1=100 phase2=0 phase3=0 phase4=0
