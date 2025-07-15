#!/bin/bash
#FLUX: --job-name="Curaba_test"
#FLUX: --exclusive
#FLUX: --queue=EPYC
#FLUX: -t=7200
#FLUX: --priority=16

export code='/u/dssc/ccurab00/scratch/Foundations_of_HPC_2022/Assignment/exercise2'
export OMP_NUM_THREADS='64'
export OMP_PLACES='cores'
export OMP_PROC_BIND='true'

module load architecture/AMD
module load mkl
module load openBLAS/0.3.21-omp
export code=/u/dssc/ccurab00/scratch/Foundations_of_HPC_2022/Assignment/exercise2
export OMP_NUM_THREADS=64
export OMP_PLACES=cores
export OMP_PROC_BIND=true
cd $code
make clean
make cpu
gcc -fopenmp 00_where_I_am.c -o 00_where_I_am.x
rm where_I_am.csv
./00_where_I_am.x >> where_I_am_cores_true.csv
for i in {0..20}
do	let size=$((2000+2000*$i))
        for j in {1..3}
        do 
           	echo $size
                ./gemm_mkl.x $size $size $size >> 5_double_mkl_EPYC_cores_true.csv
                ./gemm_oblas.x $size $size $size >> 5_double_oblas_EPYC_cores_true.csv
        done
done
