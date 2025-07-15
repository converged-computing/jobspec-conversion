#!/bin/bash
#FLUX: --job-name=scruptious-peanut-butter-9923
#FLUX: --priority=16

module purge
module load singularity
module load anaconda
source activate py3.10
python -V
PYTHON=`which python`
lscpu
nvidia-smi
workdir=/scratch/$USER/rivanna
time singularity run --nv $workdir/tensorflow-2.7.0.sif mnist.py
