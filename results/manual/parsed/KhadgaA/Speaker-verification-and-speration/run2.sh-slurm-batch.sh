#!/bin/bash
#SBATCH --job-name=hubert_large
#SBATCH --output=first_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1

export TORCHAUDIO_USE_BACKEND_DISPATCHER='1'

date;hostname;pwd
echo "Running on host" $(hostname)
printenv | grep -i slurm | sort
module load anaconda/3
eval "$(conda shell.bash hook)"
conda activate speech_env
export TORCHAUDIO_USE_BACKEND_DISPATCHER=1
python eval_model.py --model hubert_large  &> hubert_large_full.txt 
