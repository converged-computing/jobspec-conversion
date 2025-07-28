#!/bin/bash
#FLUX: --job-name=pd
#FLUX: -N=8
#FLUX: -t=216000
#FLUX: --urgency=16

source ~/.bashrc
cd /home/salvadord/pd
mpirun -np 512 nrniv -python -mpi init.py
wait
