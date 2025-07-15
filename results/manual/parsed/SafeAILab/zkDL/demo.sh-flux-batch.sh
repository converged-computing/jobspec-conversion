#!/bin/bash
#FLUX: --job-name=persnickety-latke-5657
#FLUX: -c=6
#FLUX: -t=59
#FLUX: --urgency=16

set -e  # Exit immediately if a command exits with a non-zero status
module load gcc cuda/11.4 cmake protobuf cudnn python/3.10
virtualenv --no-download --clear $SLURM_TMPDIR/ENV && source $SLURM_TMPDIR/ENV/bin/activate
pip install torch numpy
python model.py
make clean
make demo
./demo traced_model.pt sample_input.pt
