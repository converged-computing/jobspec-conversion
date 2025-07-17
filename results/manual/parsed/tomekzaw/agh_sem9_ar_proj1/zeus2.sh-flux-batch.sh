#!/bin/bash
#FLUX: --job-name=peachy-pastry-6973
#FLUX: -n=20
#FLUX: --queue=plgrid
#FLUX: -t=7200
#FLUX: --urgency=16

module add plgrid/tools/python-intel/3.6.5 2>/dev/null
zad=2
mpiexec -np 20 python3 main.py 100 $zad > /dev/null
echo "i,zad,N,np,real_N,time"
for i in {1..10} ; do
    for N in 2000 300 50 ; do
        for np in {1..20} ; do
            echo -n "$i,$zad,$N,$np,"
            mpiexec -np $np python3 main.py $N $zad
        done
    done
done
