#!/bin/bash
#FLUX: --job-name=persnickety-bits-3729
#FLUX: -c=8
#FLUX: --queue=dgx_normal_q
#FLUX: -t=3600
#FLUX: --urgency=16

module load Python/3.11.3-GCCcore-12.3.0
python3 --version
nvidia-smi
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
python main.py
