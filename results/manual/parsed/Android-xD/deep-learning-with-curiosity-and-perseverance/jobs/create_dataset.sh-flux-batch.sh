#!/bin/bash
#FLUX: --job-name=train
#FLUX: -t=36000
#FLUX: --urgency=16

source scripts/startup.sh
cd src/data_preprocessing
python create_dataset.py
