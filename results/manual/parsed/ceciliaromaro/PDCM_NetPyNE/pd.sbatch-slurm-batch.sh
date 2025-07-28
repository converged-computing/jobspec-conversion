#!/bin/bash
#FLUX: --job-name=pd
#FLUX: -N=16
#FLUX: -t=216000
#FLUX: --urgency=16

source ~/.bashrc
cd /home/salvadord/pd
mpirun -np 1024 nrniv -python -mpi init.py
wait
