#!/bin/bash
#FLUX --job-name=grated-general-0121
#FLUX -t=28800
#FLUX --urgency=16

module load gcc python 
source ~/venvs/sillystill/bin/activate
pip install -r requirements.txt
deactivate
