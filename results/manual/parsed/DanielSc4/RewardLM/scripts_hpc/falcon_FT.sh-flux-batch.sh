#!/bin/bash
#FLUX: --job-name=fine-tune-falcon-instruct-7B
#FLUX: -t=18000
#FLUX: --urgency=16

export PATH_TO_STORAGE='/scratch/p313544/storage_cache/'

module purge
module load Python/3.9.6-GCCcore-11.2.0
module load CUDA/11.7.0
cd /home1/p313544
source .venv/bin/activate
echo "Python version: $(python --version)"
nvidia-smi
pwd
PATH_TO_PRJ=/home1/p313544/Documents/RewardLM
SCRIPT_NAME=script_FT.py
export PATH_TO_STORAGE=/scratch/p313544/storage_cache/
cd $PATH_TO_PRJ
echo "Executing python script..."
python $SCRIPT_NAME -c falcon7B
echo "Done!"
