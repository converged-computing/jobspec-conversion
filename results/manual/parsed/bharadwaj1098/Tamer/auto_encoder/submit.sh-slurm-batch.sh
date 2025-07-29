#!/bin/bash
#FLUX: --job-name=auto_encoder_type1
#FLUX: --queue=Hercules
#FLUX: -t=86400
#FLUX: --urgency=16

module load pytorch/1.6.0-anaconda3-cuda10.2
pip install --no-index --upgrade pip
conda install -c akode atari-py  
python Type_1.py
