#!/bin/bash
#FLUX: --job-name=tart-malarkey-0225
#FLUX: -c=20
#FLUX: -t=10800
#FLUX: --priority=16

module load gcc python py-torchvision py-torch
source ../../venv*/bin/activate
echo STARTING AT `date`
python test.py
echo FINISHED at `date`
