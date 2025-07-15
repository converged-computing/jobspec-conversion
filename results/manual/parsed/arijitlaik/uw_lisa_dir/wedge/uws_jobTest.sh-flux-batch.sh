#!/bin/bash
#FLUX: --job-name=astute-general-7441
#FLUX: -N=3
#FLUX: -t=86400
#FLUX: --urgency=16

echo "********** CPU-INFO**********"
lscpu
echo "********** Run Started **********"
srun -n 48 singularity exec --pwd $PWD uwgeodynamics-dev.simg  python3 Tutorial_10_Thrust_Wedges.py
wait
