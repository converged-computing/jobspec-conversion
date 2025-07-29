#!/bin/bash
#SBATCH --job-name=snakempi
#SBATCH --output=mpi-%j.out
#SBATCH --error=mpi-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --partition=priority
#SBATCH --qos=pol02003sky
#SBATCH --constraint=skylake

export TIMEFORMAT='user-seconds %3U'

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/lib"
export TIMEFORMAT="user-seconds %3U"
cd /home/pol02003/dub/mpitest
time mpirun -n 20 dubmpi
