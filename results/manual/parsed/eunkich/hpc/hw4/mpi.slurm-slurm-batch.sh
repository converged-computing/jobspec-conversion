#!/bin/bash
#FLUX: --job-name=mpi
#FLUX: --queue=ckpt
#FLUX: -t=600
#FLUX: --urgency=16

module load ompi
mpic++ -std=c++14 -o mpi.o mpi.cpp;
echo "func,val,logerr,time,n,n_process";
for i in {1..40}
do
    mpirun -np $i mpi.o $((10 ** 8));
done
for i in {1..6}
do
    mpirun -np 8 mpi.o $((10 ** $i));
done
rm *.o
