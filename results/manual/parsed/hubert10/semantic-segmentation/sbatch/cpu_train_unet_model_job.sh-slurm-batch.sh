#!/bin/bash
#FLUX: --job-name=cpu_job_train_unet_model
#FLUX: -c=16
#FLUX: -t=28800
#FLUX: --urgency=16

pwd; hostname; date
module load tensorflow/2.4.1
python model_training/training_unet_model.py
date
