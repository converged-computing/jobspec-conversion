#!/bin/bash
#FLUX: --job-name=blackbox_test
#FLUX: -n=8
#FLUX: --queue=tier3
#FLUX: -t=432000
#FLUX: --urgency=16

source ./venv/bin/activate
python train_patch.py paper_obj
deactivate
