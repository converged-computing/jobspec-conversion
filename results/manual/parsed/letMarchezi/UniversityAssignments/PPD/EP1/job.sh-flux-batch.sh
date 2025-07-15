#!/bin/bash
#FLUX: --job-name=salted-signal-5674
#FLUX: -c=40
#FLUX: --urgency=16

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
