#!/bin/bash
#FLUX: --job-name=Curaba_test
#FLUX: --exclusive
#FLUX: --queue=EPYC
#FLUX: -t=2700
#FLUX: --urgency=16

export code='/u/dssc/ccurab00/scratch/Foundations_of_HPC_2022/Assignment/exercise2'
export OMP_PLACES='sockets'
export OMP_PROC_BIND='true'

module load architecture/AMD
module load mkl
module load openBLAS/0.3.21-omp
export code=/u/dssc/ccurab00/scratch/Foundations_of_HPC_2022/Assignment/exercise2
export OMP_PLACES=sockets
export OMP_PROC_BIND=true
cd $code
make clean
make cpu
gcc -fopenmp 00_where_I_am.c -o 00_where_I_am.x
rm where_I_am.csv
size=10000
for i in $(seq 1 8 65);
do	let size=$(($size))
        for j in {1..2}
        do
		srun -n 1 --cpu-bind=cores --cpus-per-task=$i ./00_where_I_am.x >> where_I_am.csv
		srun -n 1 --cpu-bind=cores --cpus-per-task=$i ./gemm_mkl.x $size $size $size >> 6_float_mkl_EPYC_cpus.csv
		srun -n 1 --cpu-bind=cores --cpus-per-task=$i ./gemm_oblas.x $size $size $size >> 6_float_oblas_EPYC_cpus.csv
        done
done
