#!/bin/bash
#FLUX: --job-name=psycho-snack-5346
#FLUX: -n=32
#FLUX: --queue=seas_gpu
#FLUX: -t=43200
#FLUX: --urgency=16

source venv/bin/activate
python model_training.py
