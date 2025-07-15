#!/bin/bash
#FLUX: --job-name=phat-eagle-5631
#FLUX: -c=40
#FLUX: --urgency=16

lscpu
echo "*** SEQUENTIAL LAPLACE EQUATION GRID 1000X1000 ***"
srun singularity run container.sif laplace_seq_it 1000
echo " "
echo "*** OPENMP LAPLACE EQUATION grid 1000x1000 ***"
for j in 1 2 5 10 20 40
do
	export OMP_NUM_THREADS=$j
	echo "OPENMP PARALLEL LAPLACE EQUATION WITH $j THREADS"
	srun singularity run container.sif laplace_omp_it 1000
	echo "----------------------------------------------"
	echo " "
done
