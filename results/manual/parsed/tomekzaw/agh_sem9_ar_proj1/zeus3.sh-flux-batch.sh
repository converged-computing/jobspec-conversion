#!/bin/bash
#FLUX: --job-name=spicy-taco-2079
#FLUX: -n=20
#FLUX: --queue=plgrid
#FLUX: -t=7200
#FLUX: --urgency=16

module add plgrid/tools/python-intel/3.6.5 2>/dev/null
zad=3
mpiexec -np 20 python3 main.py 100 $zad > /dev/null
echo "i,zad,N,np,real_N,time"
for i in {1..5} ; do
    for N in 1000 100 ; do
        for np in {1..20} ; do
            echo -n "$i,$zad,$N,$np,"
            mpiexec -np $np python3 main.py $N $zad
        done
    done
done
