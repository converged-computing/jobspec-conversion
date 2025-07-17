#!/bin/bash
#FLUX: --job-name=ndl-pytest
#FLUX: -c=6
#FLUX: -t=1200
#FLUX: --urgency=16

SOURCEDIR=~/ndl
VENV_DIR=~/pytorch_gpu
module load python/3.6
source $VENV_DIR/bin/activate # virtual environment for project
cd $SOURCEDIR
pytest 
