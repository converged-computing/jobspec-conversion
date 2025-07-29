#!/bin/bash
#FLUX: --job-name=eacikgoz17_transformer_baseline_analysis_deu
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
python transformer.py analysis deu
source deactivate
