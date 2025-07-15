#!/bin/bash
#FLUX: --job-name=thesis_job
#FLUX: -c=4
#FLUX: --queue=batch
#FLUX: -t=172800
#FLUX: --priority=16

module load gcc miniconda3
source $CONDA_PROFILE/conda.sh
conda activate thesis
cd ~/thesis
ls
pip install -U -r requirements.txt
python train.py
