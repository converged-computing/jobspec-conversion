#!/bin/bash
#FLUX: --job-name=trainResNetUlm
#FLUX: -c=6
#FLUX: -t=86340
#FLUX: --urgency=16

cd ~/IFT-6164-ConditionalGenerationUS
module load python/3.9
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip
pip install --no-index -r requirementsCC.txt
cp -rv ~/scratch/data/data_CGenULM/patchesIQ_small_shuffled $SLURM_TMPDIR/
python trainResNetULM.py
