#!/bin/bash
#FLUX: --job-name=Pysster-snakemake
#FLUX: -c=4
#FLUX: --queue=gpu_p
#FLUX: -t=21600
#FLUX: --urgency=15

sbatch --wait << EOF
source $HOME/.bashrc
conda activate pysster-same-padding
python scripts/train_Pysster.py --params $1 --save-model-only -o $2 --in-fasta $3 $4
EOF
