#!/bin/bash
#FLUX: --job-name=gpu_fng2
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

conda create --name pytorch_env python=3.10 -y
source activate pytorch_env
conda install scikit-image pytorch torchvision torchaudio pytorch-cuda=11.8 -c pytorch -c nvidia -y
pip install joblib matplotlib numpy pandas scikit-learn scipy seaborn
python new_test_fash_nogroup2.py
