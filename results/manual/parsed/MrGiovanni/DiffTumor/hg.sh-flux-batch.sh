#!/bin/bash
#FLUX: --job-name=install
#FLUX: --priority=16

module load mamba/latest # only for Sol
source activate difftumor
pip install torch==1.12.1+cu113 torchvision==0.13.1+cu113 torchaudio==0.12.1 --extra-index-url https://download.pytorch.org/whl/cu113
pip install -r requirements.txt
