#!/bin/bash
#FLUX: --job-name=python_train_BERT
#FLUX: --queue=gpu
#FLUX: -t=7200
#FLUX: --priority=16

module purge
module load TensorFlow/2.5.0-fosscuda-2020b
pip install -r code/requirements.txt --user
mpirun python code/pre_train_model.py
