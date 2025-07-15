#!/bin/bash
#FLUX: --job-name=phat-cherry-2583
#FLUX: --priority=16

source ./venv/bin/activate
python train_patch.py paper_obj
deactivate
