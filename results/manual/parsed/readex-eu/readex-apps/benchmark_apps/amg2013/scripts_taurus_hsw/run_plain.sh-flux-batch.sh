#!/bin/bash
#FLUX: --job-name=fat-buttface-8183
#FLUX: -N=4
#FLUX: -c=12
#FLUX: --exclusive
#FLUX: --queue=haswell
#FLUX: -t=1800
#FLUX: --urgency=16

cd ..
module purge
source ./readex_env/set_env_plain.source
srun --cpu_bind=verbose,sockets --nodes 4 --ntasks-per-node 2 --cpus-per-task 12 ./test/amg2013_plain -P 2 2 2 -r 40 40 40 
