#!/bin/bash
#FLUX: --job-name=ornery-hippo-3152
#FLUX: -c=6
#FLUX: --queue=long
#FLUX: -t=21600
#FLUX: --urgency=16

export PYTHONUNBUFFERED='1'

module load python/3.8 cuda/11.1
export PYTHONUNBUFFERED=1
module load python/3.8
cd $SLURM_TMPDIR/
virtualenv --no-download venv
source venv/bin/activate
cd ~/lambo
pip install --no-index --find-links=~/wheels/ -r requirements-cc.txt
pip install -e .
pkill -9 wandb
python scripts/black_box_opt.py "$@"
