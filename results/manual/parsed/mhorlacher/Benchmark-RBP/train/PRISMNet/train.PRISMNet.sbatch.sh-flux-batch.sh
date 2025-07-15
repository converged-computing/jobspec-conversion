#!/bin/bash
#FLUX: --job-name=scruptious-muffin-7083
#FLUX: --priority=15

sbatch --wait <<- EOF
mkdir logs
source $HOME/.bashrc
conda activate prismnet
python -u ../../methods/PrismNet/main.py --train --eval --lr 0.001 --data_dir $1 --p_name all.train --out_dir $1
EOF
