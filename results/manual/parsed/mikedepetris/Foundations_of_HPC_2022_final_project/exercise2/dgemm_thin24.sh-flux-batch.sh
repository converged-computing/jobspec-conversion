#!/bin/bash
#FLUX: --job-name=dgemm_thin
#FLUX: --exclusive
#FLUX: --queue=THIN
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_PLACES='cores'
export OMP_PROC_BIND='spread'
export OMP_NUM_THREADS='24'
export BLIS_NUM_THREADS='24'
export LD_LIBRARY_PATH='/u/dssc/mdepet00/assignment/exercise2/blis/lib:$LD_LIBRARY_PATH'

module load mkl
module load openBLAS/0.3.23-omp
export OMP_PLACES=cores
export OMP_PROC_BIND=spread
export OMP_NUM_THREADS=24
export BLIS_NUM_THREADS=24
export LD_LIBRARY_PATH=/u/dssc/mdepet00/assignment/exercise2/blis/lib:$LD_LIBRARY_PATH
echo size scalability begin
now=$(date +"%Y-%m-%d_%H-%M-%S")
for LIB in oblas_optimized oblas mkl_optimized mkl blis_optimized blis; do
  csvname=dgemm_"$LIB"_thin_$(hostname)_$now.csv
  #echo "$csvname $(hostname) $now"
  #echo "$csvname"
  #2000,2000,2000,0.034462963,0.034463,464.266523
  echo "m,n,k,elapsed1,elapsed2,GFLOPS" >"$csvname"
done
for REP in {1..10}; do
  for LIB in oblas_optimized oblas mkl_optimized mkl blis_optimized blis; do
  csvname=dgemm_"$LIB"_thin_$(hostname)_$now.csv
  #srun -n1 --cpus-per-task=24 ./dgemm_oblas.x 2000 2000 200>discarded_first_result_"$csvname"
  #echo "$csvname $(hostname) $now">"$csvname"
    #increase the size of matrices size from 2000x2000 to 20000x20000 (single precision) and analyse the scaling of the GEMM calculation for at least MKL and openblas.
    for SIZE in {30000..2000..500}; do
      echo dgemm_thin_job_"$SLURM_JOB_ID".out$'\t'"$csvname"$'\t'"$(hostname)"$'\t'rep "$REP" size "$SIZE" OMP_PLACES=$OMP_PLACES OMP_PROC_BIND=$OMP_PROC_BIND OMP_NUM_THREADS=$OMP_NUM_THREADS BLIS_NUM_THREADS=$BLIS_NUM_THREADS srun -n1 --cpus-per-task=24 ./dgemm_$LIB.x "$SIZE" "$SIZE" "$SIZE"'>>'"$csvname"
      srun -n1 --cpus-per-task=24 ./dgemm_$LIB.x "$SIZE" "$SIZE" "$SIZE" >>"$csvname"
      #srun -n1 --cpus-per-task=24 ./dgemm_oblas.x 2000 2000 2000
    done
  done
done
now=$(date +"%Y-%m-%d_%H-%M-%S")
echo "$(hostname)" "$now" END
echo size scalability end
