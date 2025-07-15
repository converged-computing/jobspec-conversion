#!/bin/bash
#FLUX: --job-name=tox_meter_red
#FLUX: -t=10800
#FLUX: --priority=16

export PATH_TO_STORAGE='/scratch/p313544/storage_cache/ret_toxicity'

module purge
module load Python/3.9.6-GCCcore-11.2.0
module load CUDA/11.7.0
cd /home1/p313544
source .venv/bin/activate
echo "Python version: $(python --version)"
nvidia-smi
pwd
PATH_TO_PRJ=/home1/p313544/Documents/RewardLM
SCRIPT_NAME=scriptToxicity.py
export PATH_TO_STORAGE=/scratch/p313544/storage_cache/ret_toxicity
cd $PATH_TO_PRJ
echo "Executing 3 python script..."
echo "[PT]"
python $SCRIPT_NAME -c RedPajama-INCITE-Chat-3B-v1
echo "[FT]"
python $SCRIPT_NAME -c RedPajama-INCITE-Chat-3B-LoRA-FT
echo "[RL]"
python $SCRIPT_NAME -c RedPajama-INCITE-Chat-3B-LoRA-RL
echo "Done!"
