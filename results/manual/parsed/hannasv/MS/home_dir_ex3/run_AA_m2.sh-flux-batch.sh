#!/bin/bash
#FLUX: --job-name=crusty-motorcycle-5391
#FLUX: --priority=16

ulimit -s 10240
mkdir -p ~/output
. ar_venv/bin/activate # activate project enviornment
module purge
module load slurm/18.08.9
module load mpfr/gcc/4.0.2
module load gmp/gcc/6.1.2
module load mpc/gcc/1.1.0
module load gcc/9.1.1
module load openmpi/gcc/64/1.10.7
python /home/hannasv/MS/sclouds/ml/regression/AA_m2.py
