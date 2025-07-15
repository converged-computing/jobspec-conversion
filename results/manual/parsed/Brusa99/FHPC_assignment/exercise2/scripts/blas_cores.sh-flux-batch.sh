#!/bin/bash
#FLUX: --job-name="blas_cores"
#FLUX: -c=64
#FLUX: --exclusive
#FLUX: --queue=EPYC
#FLUX: -t=7200
#FLUX: --priority=16

export OMP_PLACES='cores'
export OMP_PROC_BIND='spread'

module load architecture/AMD
module load mkl
module load openBLAS/0.3.21-omp
export OMP_PLACES=cores
export OMP_PROC_BIND=spread
echo cores,m,k,n,time,GFLOPS >> ~/scratch/blas_core_double.csv
m=10000
for i in {1..64}
do
	export OMP_NUM_THREADS=$i
	for j in {1..5}
	do
		echo -n $i, >> ~/scratch/blas_core_double.csv
		../gemm_oblas.x $m $m $m >> ~/scratch/blas_core_double.csv
	done
done
