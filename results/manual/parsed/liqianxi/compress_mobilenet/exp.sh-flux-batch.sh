#!/bin/bash
#FLUX --job-name=faux-bike-7675
#FLUX -c=8
#FLUX -t=60
#FLUX --urgency=16

module load python/3.9
source venv/bin/activate
python3.9 code/main.py
