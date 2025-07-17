#!/bin/bash
#FLUX: --job-name=snakemake
#FLUX: -c=4
#FLUX: --queue=gpu_p
#FLUX: -t=21600
#FLUX: --urgency=15

sbatch --wait << EOF
source $HOME/.bashrc
conda activate rnaprotenv
rnaprot train --in $1 --out $1 --use-eia --use-phastcons --use-phylop --verbose-train
EOF
