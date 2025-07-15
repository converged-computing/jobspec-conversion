#!/bin/bash
#FLUX: --job-name=example # Name of the job
#FLUX: --priority=16

source /etc/profile
source env/bin/activate
module load cuda/10.0-cudnn7.4
python -u example.py
