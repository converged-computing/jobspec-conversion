#!/bin/bash
#SBATCH --job-name=laplace
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --time=01:30:00

echo "*** SEQUENTIAL LAPLACE EQUATION GRID 1000X1000 ***"
srun singularity run container.sif laplace_seq_it 1000
echo " "
echo "*** PTHREAD LAPLACE EQUATION grid 1000x1000 ***"
for i in 1 2 5 10 20 40
do
	echo "*** Parallel algorithm with $i threads ***"
	srun singularity run container.sif laplace_pth_it 1000 $i
	echo " "
done
