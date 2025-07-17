#!/bin/bash
#FLUX: --job-name=boopy-destiny-9165
#FLUX: -n=32
#FLUX: --queue=dev_q
#FLUX: -t=7200
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
