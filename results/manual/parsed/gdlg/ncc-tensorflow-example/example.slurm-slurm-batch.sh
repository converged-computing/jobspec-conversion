#!/bin/bash
#FLUX: --job-name=example
#FLUX: -c=4
#FLUX: --queue=res-gpu-small
#FLUX: -t=86400
#FLUX: --urgency=16

source /etc/profile
source env/bin/activate
module load cuda/10.0-cudnn7.4
python -u example.py
