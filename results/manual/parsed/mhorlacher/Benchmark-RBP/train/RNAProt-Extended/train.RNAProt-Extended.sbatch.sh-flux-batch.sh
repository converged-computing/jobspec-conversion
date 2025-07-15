#!/bin/bash
#FLUX: --job-name=lovely-kerfuffle-3227
#FLUX: --urgency=15

sbatch --wait << EOF
source $HOME/.bashrc
conda activate rnaprotenv
rnaprot train --in $1 --out $1 --use-eia --use-phastcons --use-phylop --verbose-train
EOF
