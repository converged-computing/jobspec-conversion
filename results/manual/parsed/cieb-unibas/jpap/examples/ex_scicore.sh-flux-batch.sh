#!/bin/bash
#FLUX: --job-name=jpap-ipl
#FLUX: -c=8
#FLUX: --queue=a100
#FLUX: -t=600
#FLUX: --urgency=16

ml load CUDA/11.7.0
cd "/scicore/home/weder/GROUP/Innovation/05_job_adds_data/jpap/"
source ../jpap-venv/bin/activate
python examples/ex.py
