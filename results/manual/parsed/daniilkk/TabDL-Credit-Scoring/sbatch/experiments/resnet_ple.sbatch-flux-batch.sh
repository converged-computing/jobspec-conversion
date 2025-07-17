#!/bin/bash
#FLUX: --job-name=resnet_ple
#FLUX: -c=8
#FLUX: -t=12000
#FLUX: --urgency=16

export PYTHONPATH='$(pwd)'

module purge
module load Python
deactivate
source activate venv
pip install -r requirements.txt
export PYTHONPATH=$(pwd)
for _ in $(seq 1 5); do
    python -u src/train.py --experiment resnet_ple
done
