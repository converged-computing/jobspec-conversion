#!/bin/bash
#SBATCH --job-name=test
#SBATCH --account=vulcan
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --qos=vulcan_debug
#SBATCH --constraint=ntasks-per-node=8

user=`whoami`
cd /clusterfs/vulcan/pscratch/$user/taskfarmer/python
shuf examples/commands.txt | head -n 200 > tasks.txt
if [ -f log ]; then
    rm log
fi
module load python/2.7.3 mpi4py
mpirun -np 16 taskfarmer.py -f tasks.txt -v
