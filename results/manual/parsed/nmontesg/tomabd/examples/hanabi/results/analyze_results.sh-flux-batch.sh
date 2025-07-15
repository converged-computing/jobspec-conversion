#!/bin/bash
#FLUX: --job-name=hanabi_runs
#FLUX: -N=4
#FLUX: -c=20
#FLUX: -t=43200
#FLUX: --urgency=16

spack load anaconda3@2021.05
for i in {2..5}
do
    srun -N1 -n1 --exclusive /home/nmontes/.conda/envs/hanabi/bin/python single.py $1 $i &
done
wait
