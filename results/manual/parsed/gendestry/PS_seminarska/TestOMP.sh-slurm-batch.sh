#!/bin/bash
#SBATCH --job-name=PageRank-OpenMP
#SBATCH --output=log/openmp-tests.log
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8000
#SBATCH --time=08:00:00
#SBATCH --constraint=AMD

export OMP_PLACES='cores'
export OMP_PROC_BIND='close'

export OMP_PLACES=cores
export OMP_PROC_BIND=close
for THREADS in 1 2 4 8 16 32 64
do
	export OMP_NUM_THREADS=$THREADS
	echo "NUM_THREADS:" $THREADS
	for ITERTYPE in 0 1
	do
		echo "#ITERTYPE:" $ITERTYPE
		for DATATYPE in 0 1
		do
			echo "##DATATYPE:" $DATATYPE
			for VERTICES in 10000 20000 50000 100000 200000 500000 -1
			do
				echo "###VERTICES:" $VERTICES
				for ITERS in {1..25}
				do
					bin/PageRank-OpenMP 1e-7 $DATATYPE $VERTICES $ITERTYPE
				done
			done
		done
	done
done
