#!/bin/bash
#FLUX: --job-name=carnivorous-signal-3630
#FLUX: -t=36000
#FLUX: --urgency=16

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
