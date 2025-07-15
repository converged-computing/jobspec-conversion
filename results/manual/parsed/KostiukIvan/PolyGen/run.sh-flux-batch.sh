#!/bin/bash
#FLUX: --job-name=train_H
#FLUX: --queue=student
#FLUX: --priority=16

export PYTHONPATH='./'

cd ~/dev/PolyGen
source ~/miniconda3/bin/activate
conda activate torch_env
export PYTHONPATH=./
python experiments/main.py -load_weights /home/z1142375/dev/PolyGen/weights/23_07_2021_23_31/epoch_1740.pt
