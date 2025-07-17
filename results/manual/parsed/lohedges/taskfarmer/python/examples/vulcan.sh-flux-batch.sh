#!/bin/bash
#FLUX: --job-name=test
#FLUX: -N=2
#FLUX: --queue=vulcan
#FLUX: -t=300
#FLUX: --urgency=16

user=`whoami`
cd /clusterfs/vulcan/pscratch/$user/taskfarmer/python
shuf examples/commands.txt | head -n 200 > tasks.txt
if [ -f log ]; then
    rm log
fi
module load python/2.7.3 mpi4py
mpirun -np 16 taskfarmer.py -f tasks.txt -v
