#!/bin/bash
#FLUX: --job-name=Mfftw
#FLUX: -c=16
#FLUX: --priority=16

. /etc/profile
module load cuda/5.0
srun cat /proc/cpuinfo > cpuinfo.dat
for i in 1 2 4 8 16
do
	echo
	echo "=== FFTW multiple threads ==="
	export OMP_NUM_THREADS=$i
	time srun -n1 simple_fftw_threads
	echo
done
wait
