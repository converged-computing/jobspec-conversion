#!/bin/bash
#FLUX: --job-name=ML541-final
#FLUX: -n=20
#FLUX: --queue=short
#FLUX: -t=43200
#FLUX: --urgency=16

module load python/3.12.3/mftt2ua
module load cuda11.7/toolkit/11.7.1
python -m venv env
source env/bin/activate
pip install -r requirements.txt
python3 data_argument.py
