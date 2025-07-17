#!/bin/bash
#FLUX: --job-name=misunderstood-banana-5318
#FLUX: -N=8
#FLUX: -c=8
#FLUX: --urgency=16

export LD_PRELOAD='/spack/apps/gcc/8.3.0/lib64/libstdc++.so.6'

export LD_PRELOAD=/spack/apps/gcc/8.3.0/lib64/libstdc++.so.6
fileName="data-1000000-32.txt"
for k in 4 8 16
do
	for n in 2 4 8
	do
		mpirun -bind-to none -n $n ./mpi_main -s $fileName -k $k
		for t in 2 4 6 8 
		do
			mpirun -bind-to none -n $n ./mpi_main -s $fileName -k $k -t $t
		done
	done
done
fileName="data-10000000-32.txt"
for k in 4 8 16
do
        for n in 2 4 8
        do
                mpirun -bind-to none -n $n ./mpi_main -s $fileName -k $k
                for t in 2 4 6 8
                do
                        mpirun -bind-to none -n $n ./mpi_main -s $fileName -k $k -t $t
                done
        done
done
