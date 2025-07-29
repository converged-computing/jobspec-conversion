#!/bin/bash
#FLUX: --job-name=demo
#FLUX: -c=4
#FLUX: -t=129600
#FLUX: --urgency=16

source ~/miniconda3/etc/profile.d/conda.sh
conda activate fsd
pip install .
streamlit run demo/app.py --server.fileWatcherType none --server.port 20226
