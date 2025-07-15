#!/bin/bash
#FLUX: --job-name=moolicious-animal-3154
#FLUX: --priority=15

sbatch --wait << EOF
source $HOME/.bashrc
conda activate pysster-same-padding
python scripts/train_Pysster.py --params $1 --save-model-only -o $2 --in-fasta $3 $4
EOF
