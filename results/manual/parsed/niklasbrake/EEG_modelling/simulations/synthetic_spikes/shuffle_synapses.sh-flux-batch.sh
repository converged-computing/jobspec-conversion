#!/bin/bash
#FLUX: --job-name=butterscotch-staircase-5756
#FLUX: -t=3600
#FLUX: --urgency=16

module load python/3.8.10
module load mpi4py
module load scipy-stack
module load matlab/2020a
module load neuron
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip --quiet
pip install --no-index LFPy --quiet
pip install --no-index umap-learn
srun matlab -nodisplay -r "shuffle_synapses"
