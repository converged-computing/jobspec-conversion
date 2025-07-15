#!/bin/bash
#FLUX: --job-name=blank-sundae-4579
#FLUX: -c=4
#FLUX: --queue=main
#FLUX: -t=1800
#FLUX: --priority=16

source batch_jobs/_experiment_configuration.sh
echo "Host - $HOSTNAME"
echo "Commit - $(git rev-parse HEAD)"
nvidia-smi
module load python/3.7
virtualenv $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
cd $HOME/workspace/debias-eval
python -m pip install -e .
python -u "$@" --persistent_dir ${persistent_dir}
