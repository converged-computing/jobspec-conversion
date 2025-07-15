#!/bin/bash
#FLUX: --job-name=vulchecker_setup
#FLUX: -c=2
#FLUX: --queue=gpu-tk
#FLUX: --urgency=16

export HOME='/ukp-storage-1/schroeder_e/'

export HOME=/ukp-storage-1/schroeder_e/
mkdir -p /ukp-storage-1/schroeder_e/VulChecker/
/ukp-storage-1/schroeder_e/python3.8/Python-3.8.18/python -m venv /ukp-storage-1/schroeder_e/VulChecker/venv
source /ukp-storage-1/schroeder_e/VulChecker/venv/bin/activate
module load cuda/10.0
cd /ukp-storage-1/schroeder_e/VulChecker
git clone https://github.com/ymirsky/VulChecker.git
git clone https://github.com/gtri/structure2vec.git
pip install -U pip setuptools wheel
pip install cython cmake
pip install ./structure2vec
pip --no-cache-dir install ./VulChecker
