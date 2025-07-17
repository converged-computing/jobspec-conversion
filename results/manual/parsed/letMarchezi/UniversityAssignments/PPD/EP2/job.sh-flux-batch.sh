#!/bin/bash
#FLUX: --job-name=laplace
#FLUX: -c=40
#FLUX: --queue=fast
#FLUX: -t=5400
#FLUX: --urgency=16

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
