#!/bin/bash
#FLUX: --job-name=nnqs_training
#FLUX: -c=12
#FLUX: -t=21600
#FLUX: --urgency=16

module load anaconda gcc openmpi
pip install --upgrade "jax[cpu]" "ray[tune]" "netket[mpi]" hyperopt hiplot typing-extensions
srun python run_tuning.py --num_samples 300
