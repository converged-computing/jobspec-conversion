#!/bin/bash
#FLUX: --job-name=Contrastive_VIT
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=72000
#FLUX: --urgency=16

module purge
module load PyTorch
source ./venv/bin/activate
pip install -r requirements.txt
nvidia-smi
python VIT_contrastive.py \
 -l 250\
 -e contrastive-250\
 -d /gpfs/projects/acad/lsfb/datasets/lsfb_v2/isol \
