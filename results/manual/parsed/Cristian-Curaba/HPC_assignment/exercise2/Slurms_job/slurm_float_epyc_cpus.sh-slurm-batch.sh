#!/bin/bash
#SBATCH --job-name=Curaba_test
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:45:00
#SBATCH --partition=EPYC
#SBATCH: --exclusive
#SBATCH: --no-requeue

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
