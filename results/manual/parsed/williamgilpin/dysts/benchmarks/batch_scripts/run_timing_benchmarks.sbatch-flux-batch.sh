#!/bin/bash
#FLUX: --job-name=benchmarks
#FLUX: --queue=normal
#FLUX: -t=9000
#FLUX: --urgency=16

conda init bash
conda info --envs
echo $PATH
source ~/work/miniconda3/etc/profile.d/conda.sh
conda activate dysts
echo $CONDA_DEFAULT_ENV
echo $CONDA_PREFIX
python timing_benchmarks2.py
