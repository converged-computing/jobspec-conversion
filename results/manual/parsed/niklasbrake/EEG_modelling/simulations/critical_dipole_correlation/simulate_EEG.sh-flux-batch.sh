#!/bin/bash
#FLUX: --job-name=bricky-cherry-5426
#FLUX: -t=108000
#FLUX: --priority=16

folder=$1
S=$2
module load python/3.8.10
module load mpi4py
module load scipy-stack
module load matlab/2020a
module load neuron
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip --quiet
pip install --no-index LFPy --quiet
matlab -nodisplay -r "simulate_EEG('$folder',${SLURM_ARRAY_TASK_ID},$S)"
