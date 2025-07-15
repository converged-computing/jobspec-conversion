#!/bin/bash
#FLUX: --job-name=butterscotch-carrot-1964
#FLUX: --priority=16

ulimit -s 10240
mkdir -p ~/output
. py37-venv/bin/activate # activate project enviornment
module purge
module load slurm/18.08.9
module load mpfr/gcc/4.0.2
module load gmp/gcc/6.1.2
module load mpc/gcc/1.1.0
module load gcc/9.1.1
module load openmpi/gcc/64/1.10.7
module load ex3-modules
module load cuda10.1/toolkit/10.1.243
module load python/3.7.4
python /home/hannasv/MS/sclouds/ml/ConvLSTM/m10.py
