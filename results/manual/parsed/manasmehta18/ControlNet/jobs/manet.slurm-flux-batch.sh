#!/bin/bash
#FLUX: --job-name=manet-run
#FLUX: --urgency=16

set -x
cd /ocean/projects/iri180005p/mmehta1/ControlNet
pwd
conda deactivate
module load anaconda3/2020.11
conda activate control
nvidia-smi
python train_manet.py
