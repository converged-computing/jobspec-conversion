#!/bin/bash
#FLUX: --job-name=hubert_large
#FLUX: -c=4
#FLUX: --queue=gpu2
#FLUX: --urgency=16

export TORCHAUDIO_USE_BACKEND_DISPATCHER='1'

date;hostname;pwd
echo "Running on host" $(hostname)
printenv | grep -i slurm | sort
module load anaconda/3
eval "$(conda shell.bash hook)"
conda activate speech_env
export TORCHAUDIO_USE_BACKEND_DISPATCHER=1
python eval_model.py --model hubert_large  &> hubert_large_full.txt 
