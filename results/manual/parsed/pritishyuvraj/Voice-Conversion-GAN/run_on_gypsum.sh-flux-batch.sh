#!/bin/bash
#FLUX: --job-name=1-gpu-bidaf-pytorch
#FLUX: --queue=m40-long
#FLUX: --urgency=16

echo $SLURM_JOBID - `hostname` >> ~/slurm-jobs.txt
module purge
module load python/3.6.1
module load cuda80/blas/8.0.44
module load cuda80/fft/8.0.44
module load cuda80/nsight/8.0.44
module load cuda80/profiler/8.0.44
module load cuda80/toolkit/8.0.44
python -m train.py
