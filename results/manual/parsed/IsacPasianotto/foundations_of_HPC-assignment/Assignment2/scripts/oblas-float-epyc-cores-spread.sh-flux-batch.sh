#!/bin/bash
#FLUX: --job-name="ex2-AMD"
#FLUX: -c=64
#FLUX: --exclusive
#FLUX: --queue=EPYC
#FLUX: -t=3600
#FLUX: --priority=16

export LD_LIBRARY_PATH='/u/dssc/ipasia00/myblis/lib:$LD_LIBRARY_PATH'
export OMP_PLACES='cores'
export OMP_PROC_BIND='spread'
export OMP_NUM_THREADS='64'

cd ..
module load architecture/AMD
module load mkl
module load openBLAS/0.3.21-omp
export LD_LIBRARY_PATH=/u/dssc/ipasia00/myblis/lib:$LD_LIBRARY_PATH
export OMP_PLACES=cores
export OMP_PROC_BIND=spread
export OMP_NUM_THREADS=64
echo m,k,n,time,GFLOPS > ./results/oblas-float-epyc-cores-spread.csv
for size in {2000..20000..1000}
do
	for i in {1..15}
	do
		numactl --interleave=0-7 ./gemm_oblas.x $size $size $size >> ./results/oblas-float-epyc-cores-spread.csv
	done
done
