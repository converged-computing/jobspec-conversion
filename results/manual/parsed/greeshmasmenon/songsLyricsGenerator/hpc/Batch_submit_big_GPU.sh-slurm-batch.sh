#!/bin/bash
#SBATCH --job-name=SLG
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=10:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=1

print_error_and_exit() { echo "***ERROR*** $*"; exit 1; }
module purge || print_error_and_exit "No 'module' command"
nvidia-smi
module load lang/Python
source slg_env/bin/activate
module load  vis/FFmpeg
pip install --upgrade pip wheel
pip install pydub
pip install lightning-flash
pip install 'lightning-flash[audio,text]'
pip install --force-reinstall soundfile
python /home/users/gmenon/workspace/songsLyricsGenerator/src/torch_lightning_dali.py
wait $pid
