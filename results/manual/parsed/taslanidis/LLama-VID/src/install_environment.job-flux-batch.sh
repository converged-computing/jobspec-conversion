#!/bin/bash
#FLUX: --job-name=InstallEnvironment
#FLUX: -c=18
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --urgency=16

set -e 
module purge
module load 2022
module load Miniconda3/4.12.0
module load CUDA/11.7.0
conda create -n llamavid python=3.10 -y
source activate llamavid
pip install --upgrade pip
pip install -e .
pip install openpyxl
pip install ninja
pip install flash-attn==2.1.2.post3 --no-build-isolation
pip install openai==0.28.0
pip install -U openai-whisper
conda install -c conda-forge code-server
