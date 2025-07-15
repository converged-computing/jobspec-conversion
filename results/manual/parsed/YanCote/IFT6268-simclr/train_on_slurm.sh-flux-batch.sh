#!/bin/bash
#FLUX: --job-name=strawberry-pastry-7438
#FLUX: -t=600
#FLUX: --urgency=16

module load python/3.7
virtualenv --no-download $SLURM_TMPDIR/env
echo $SLURM_TMPDIR
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index tensorflow_gpu==2
pip install --no-index pandas
pip install --no-index opencv-python
pip install --no-index matplotlib
pip install --no-index tqdm
pip install --no-index pytz
which python
which pip
pip freeze
echo ""
echo "Calling python train script."
stdbuf -oL python -u test.py
echo "testing done!!!!!!"
mkdir ~/IFT6268-simclr/slurm_out
rsync slurm-%a.out ~/IFT6268-simclr/slurm_out/slurm-%a.out
