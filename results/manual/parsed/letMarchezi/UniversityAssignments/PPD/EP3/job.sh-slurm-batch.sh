#!/bin/bash
#SBATCH --job-name=laplace
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --time=01:30:00
#SBATCH --partition=fast

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
