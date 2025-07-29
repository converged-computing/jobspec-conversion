#!/bin/bash
#FLUX: --job-name=amg2013_plain
#FLUX: -N=4
#FLUX: -c=14
#FLUX: --exclusive
#FLUX: --queue=broadwell
#FLUX: -t=1800
#FLUX: --urgency=16

cd ..
module purge
source ./readex_env/set_env_plain.source
srun --cpu_bind=verbose,sockets --nodes 4 --ntasks-per-node 2 --cpus-per-task 14 ./test/amg2013_plain -P 2 2 2 -r 40 40 40 
