#!/bin/bash
#FLUX: --job-name=crunchy-general-2518
#FLUX: --urgency=16

source venv/bin/activate
python model_training.py
