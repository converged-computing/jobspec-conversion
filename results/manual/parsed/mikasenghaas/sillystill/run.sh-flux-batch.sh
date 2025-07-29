#!/bin/bash
#FLUX --job-name=creamy-blackbean-1628
#FLUX -t=28800
#FLUX --urgency=16

module load gcc python 
source ~/venvs/sillystill/bin/activate
pip install -r requirements.txt
deactivate
