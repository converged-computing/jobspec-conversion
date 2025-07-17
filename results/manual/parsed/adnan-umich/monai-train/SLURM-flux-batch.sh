#!/bin/bash
#FLUX: --job-name=psycho-butter-9667
#FLUX: --queue=gpu
#FLUX: -t=72300
#FLUX: --urgency=16

cd /home/adnanzai/project/monai-train
ml purge
module load python/3.11 poetry cuda
source $(poetry env info --path)/bin/activate
python -m monai-ops --optuna ./example/optuna_config.yaml --data=/home/adnanzai/mice_data_v2 --output /home/adnanzai/optuna --seed 0
