#!/bin/bash
#FLUX: --job-name=gloopy-muffin-3156
#FLUX: -t=30
#FLUX: --urgency=16

source /home/syz/sdecouplings/bin/activate
SRAND=$RANDOM
echo $SRAND
nvidia-smi
python faces.py --srcpath /home/syz/syz/wtf/src --n_iter 25 --outfile "output_$SRAND" --r __R__ --srand $SRAND
