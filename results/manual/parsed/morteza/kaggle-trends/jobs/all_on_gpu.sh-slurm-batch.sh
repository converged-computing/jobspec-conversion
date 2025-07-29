#!/bin/bash
#FLUX: --job-name=all_on_gpu
#FLUX: -t=60
#FLUX: --urgency=16

. /etc/profile.d/lmod.sh
conda env create -f environment.yml
conda activate kaggle-trends
python workspace/kaggle-trends/src/automl_loading.py
