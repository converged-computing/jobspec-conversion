#!/bin/bash
#FLUX: --job-name=python_train_BERT
#FLUX: --queue=gpu
#FLUX: -t=36000
#FLUX: --urgency=16

module purge
module load TensorFlow/2.5.0-fosscuda-2020b
pip install -r code/requirements.txt --user
python code/1b_pre_train_model.py
