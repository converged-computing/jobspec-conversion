#!/bin/bash
#FLUX: --job-name=blank-squidward-8781
#FLUX: -n=64
#FLUX: --queue=amd_256
#FLUX: -t=1500
#FLUX: --urgency=16

procname=./build/test/allreduce
flag=""
for ((i=0;i<1;i++))
do
mpiexec $flag  -n 16 $procname
./ipdps18 16
mpiexec $flag  -n 32 $procname
./ipdps18 32
done
