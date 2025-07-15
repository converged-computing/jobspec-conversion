#!/bin/bash
#FLUX: --job-name=script
#FLUX: -c=64
#FLUX: --exclusive
#FLUX: --queue=EPYC
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_NUM_THREADS='64'
export OMP_PLACES='cores'
export OMP_PROC_BIND='spread'

module load architecture/AMD
module load openBLAS/0.3.21-omp
module load mkl
rm gemm_oblas.x
rm gemm_mkl.x
srun -n 1 make cpu
export OMP_NUM_THREADS=64
export OMP_PLACES=cores
export OMP_PROC_BIND=spread
for i in {2000..20000..1000}
do
   for j in {1..10}
   do
       srun ./gemm_oblas.x $i $i $i >> weak_scalability/double/cores_spread_oblas.csv
       srun ./gemm_mkl.x $i $i $i >> weak_scalability/double/cores_spread_mkl.csv
       echo
   done
   echo
done
