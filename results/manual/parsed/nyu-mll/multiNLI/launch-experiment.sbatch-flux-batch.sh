#!/bin/bash
#FLUX: --job-name=tart-lizard-4235
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

module load tensorflow/python2.7/20170218
PYTHONPATH=$PYTHONPATH:. python training_script model_type experiment_name --keep_rate 0.5 --learning_rate 0.0004 --alpha 0.13 --emb_train
