#!/bin/bash
#FLUX: --job-name=astute-squidward-5522
#FLUX: -c=2
#FLUX: -t=43140
#FLUX: --urgency=16

export DATA_DIR='$SLURM_TMPDIR/data'

set -o errexit    # Used to exit upon error, avoiding cascading errors
set -o errtrace    # Show error trace
set -o pipefail   # Unveils hidden failures
module load anaconda/3
conda activate sequoia
cd ~/Sequoia
cp -r data $SLURM_TMPDIR/
export DATA_DIR=$SLURM_TMPDIR/data
/home/mila/n/normandf/.conda/envs/sequoia/bin/sequoia_sweep --data_dir $SLURM_TMPDIR/data "$@"
