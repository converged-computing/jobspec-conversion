#!/bin/bash
#FLUX: --job-name=chunky-parrot-6577
#FLUX: --queue=gpu
#FLUX: -t=72300
#FLUX: --priority=16

cd /home/adnanzai/project/monai-train
ml purge
module load python/3.11 poetry cuda
source $(poetry env info --path)/bin/activate
python -m monai-ops --optuna ./example/optuna_config.yaml --data=/home/adnanzai/mice_data_v2 --output /home/adnanzai/optuna --seed 0
