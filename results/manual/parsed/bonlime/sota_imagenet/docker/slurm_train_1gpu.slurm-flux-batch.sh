#!/bin/bash
#FLUX: --job-name="imagenet experiments"
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --priority=16

python3 train.py loader.use_tfrecords=True val_loader.use_tfrecords=True +hydra_exp=$@
