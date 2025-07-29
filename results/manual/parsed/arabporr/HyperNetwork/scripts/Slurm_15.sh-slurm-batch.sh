#!/bin/bash
#FLUX: --job-name=HN_15
#FLUX: -c=6
#FLUX: -t=50340
#FLUX: --urgency=16

module purge
module load python/3.12.0
pip3 install --upgrade pip
pip3 install -U -q pandas numpy tensorflow cuda-python torch torchvision seaborn plotly matplotlib ipywidgets tqdm
python3 main.py --data_index 15
