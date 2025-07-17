#!/bin/bash
#FLUX: --job-name=red-mango-7543
#FLUX: -c=6
#FLUX: -t=600
#FLUX: --urgency=16

nvidia-smi
SOURCEDIR=/scratch/aarti9
pip install --no-index --upgrade pip
pip install --no-index -r requirements.txt
python $SOURCEDIR/vgaf_PP_Train_16F.py
