#!/bin/bash
#FLUX: --job-name=red-nalgas-4262
#FLUX: --priority=16

source venv/bin/activate
python model_training.py
