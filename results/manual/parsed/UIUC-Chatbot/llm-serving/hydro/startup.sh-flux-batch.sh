#!/bin/bash
#FLUX: --job-name=flask_server
#FLUX: --exclusive
#FLUX: --queue=a100
#FLUX: -t=3600
#FLUX: --priority=16

module load cuda/12.2.1
module load python/3.9.13
VENV_NAME="env"
if [ ! -d "$VENV_NAME" ]
then
    # The virtual environment doesn't exist, create it
    python3.9 -m venv $VENV_NAME
fi
source $VENV_NAME/bin/activate
pip install -r requirements.txt
python server.py
