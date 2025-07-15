#!/bin/bash
#FLUX: --job-name=stanky-peanut-butter-6159
#FLUX: --priority=16

procname=./build/test/allreduce
flag=""
for ((i=0;i<1;i++))
do
mpiexec $flag  -n 16 $procname
./ipdps18 16
mpiexec $flag  -n 32 $procname
./ipdps18 32
done
