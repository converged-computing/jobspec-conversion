#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=00:25:00

procname=./build/test/allreduce
flag=""
for ((i=0;i<1;i++))
do
mpiexec $flag  -n 16 $procname
./ipdps18 16
mpiexec $flag  -n 32 $procname
./ipdps18 32
done
