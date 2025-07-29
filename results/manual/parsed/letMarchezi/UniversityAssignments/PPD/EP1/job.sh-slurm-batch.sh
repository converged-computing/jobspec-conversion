#!/bin/bash
#SBATCH --job-name=mmul
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --time=01:30:00

echo "*** SEQUENTIAL ***"
srun singularity run container.sif pi_seq 1000000000
echo ""
echo "*** PTHREAD ***"
for i in 1 2 5 10 20 40
do
	echo "execucao com $i threads:"
	srun singularity run container.sif pi_pth 1000000000 $i	
done
echo ""
echo "*** OPENMP ***"
for j in 1 2 5 10 20 40
do
	echo "execucao com $j threads:"
	export OMP_NUM_THREADS=$j
	srun singularity run container.sif pi_omp 1000000000
done
