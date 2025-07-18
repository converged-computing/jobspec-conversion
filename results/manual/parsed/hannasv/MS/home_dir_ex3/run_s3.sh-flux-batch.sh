#!/bin/bash
#FLUX: --job-name=crunchy-banana-7348
#FLUX: -n=32
#FLUX: --queue=defq
#FLUX: -t=87840
#FLUX: --urgency=16

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
module load ex3-modules
module load python/3.7.4
python /home/hannasv/score3.py
