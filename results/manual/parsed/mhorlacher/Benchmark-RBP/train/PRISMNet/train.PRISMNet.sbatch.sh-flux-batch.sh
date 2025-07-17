#!/bin/bash
#FLUX: --job-name=snakemake
#FLUX: -c=4
#FLUX: --queue=gpu_p
#FLUX: -t=21600
#FLUX: --urgency=15

sbatch --wait <<- EOF
mkdir logs
source $HOME/.bashrc
conda activate prismnet
python -u ../../methods/PrismNet/main.py --train --eval --lr 0.001 --data_dir $1 --p_name all.train --out_dir $1
EOF
