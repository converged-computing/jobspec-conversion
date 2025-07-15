#!/bin/bash
#FLUX: --job-name=moolicious-bike-0041
#FLUX: -n=32
#FLUX: --priority=16

echo "Scrpt Start"
echo "Core Number:"
nproc --all
pwd
ls
echo "load Anaconda"
module load Anaconda
conda list -f scikit-learn
python --version
python main.py
echo "Scrpt End"
