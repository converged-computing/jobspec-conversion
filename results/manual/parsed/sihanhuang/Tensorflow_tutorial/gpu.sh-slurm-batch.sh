#!/bin/bash
#FLUX: --job-name=HelloWorld
#FLUX: -t=60
#FLUX: --urgency=16

module load cuda80/toolkit
module load gcc
module load anaconda
python Hello.py
