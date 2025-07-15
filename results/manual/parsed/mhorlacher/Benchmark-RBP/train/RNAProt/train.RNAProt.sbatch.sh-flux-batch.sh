#!/bin/bash
#FLUX: --job-name=stinky-sundae-6114
#FLUX: --priority=15

sbatch --wait << EOF
source $HOME/.bashrc
conda activate rnaprotenv
rnaprot train --in $1 --out $1 --verbose-train
EOF
