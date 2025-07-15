#!/bin/bash
#FLUX: --job-name=confused-cherry-0407
#FLUX: --urgency=15

sbatch --wait << EOF
source $HOME/.bashrc
conda activate rnaprotenv
rnaprot train --in $1 --out $1 --verbose-train
EOF
