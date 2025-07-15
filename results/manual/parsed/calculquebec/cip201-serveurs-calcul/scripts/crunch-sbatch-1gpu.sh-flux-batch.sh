#!/bin/bash
#FLUX: --job-name=anxious-squidward-0343
#FLUX: -t=540
#FLUX: --urgency=16

module load gcc/9.3.0 cuda/11.4 python/3.8.10
virtualenv --no-download $SLURM_TMPDIR/venv_cupy
source $SLURM_TMPDIR/venv_cupy/bin/activate
pip install --no-index numpy==1.24.2 cupy==11.2.0
time -p python scripts/crunch.py -n 672 --gpu > tg.log &
sleep 2
nvidia-smi
wait
echo Résultats:
grep sec t*.log
