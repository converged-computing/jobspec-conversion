#!/bin/bash
#FLUX: --job-name=expressive-lemon-4131
#FLUX: --priority=15

sbatch --wait << EOF
source $HOME/.bashrc
conda activate rnaprotenv
rnaprot train --in $1 --out $1 --use-eia --use-phastcons --use-phylop --verbose-train
EOF
