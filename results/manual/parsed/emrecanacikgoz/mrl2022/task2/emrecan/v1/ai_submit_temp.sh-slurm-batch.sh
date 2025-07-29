#!/bin/bash
#FLUX: --job-name=eacikgoz17_exp8_tur
#FLUX: --queue=ai
#FLUX: -t=604800
#FLUX: --urgency=16

echo "Setting stack size to unlimited..."
ulimit -s unlimited
ulimit -l unlimited
ulimit -a
echo
module load anaconda/3.6
source activate eacikgoz17
nvidia-smi
python main_tur.py 
source deactivate
