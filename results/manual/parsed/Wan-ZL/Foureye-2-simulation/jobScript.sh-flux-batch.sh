#!/bin/bash
#FLUX: --job-name=loopy-muffin-4651
#FLUX: -n=32
#FLUX: --urgency=16

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
