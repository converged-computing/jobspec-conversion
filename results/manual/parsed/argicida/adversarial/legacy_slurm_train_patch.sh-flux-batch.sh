#!/bin/bash
#FLUX: --job-name=fugly-knife-3648
#FLUX: --urgency=16

source ./venv/bin/activate
python train_patch.py paper_obj
deactivate
