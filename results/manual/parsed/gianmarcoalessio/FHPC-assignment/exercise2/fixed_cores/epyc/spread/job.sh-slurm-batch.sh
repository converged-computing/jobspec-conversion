#!/bin/bash
#FLUX: --job-name=scal_ex2
#FLUX: -n=64
#FLUX: --exclusive
#FLUX: --queue=EPYC
#FLUX: -t=7200
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/u/dssc/galess00/final_assignment_FHPC/exercise2/myblis_epyc/lib:$LD_LIBRARY_PATH'
export OMP_PLACES='cores'
export OMP_PROC_BIND='$policy'
export OMP_NUM_THREADS='64'

module load architecture/AMD
module load mkl
module load openBLAS/0.3.23-omp
export LD_LIBRARY_PATH=/u/dssc/galess00/final_assignment_FHPC/exercise2/myblis_epyc/lib:$LD_LIBRARY_PATH
location=$(pwd)
cd ../../..
make clean loc=$location
make cpu loc=$location
cd $location
policy=spread
arch=EPYC #architecture
export OMP_PLACES=cores
export OMP_PROC_BIND=$policy
export OMP_NUM_THREADS=64
libs=("blis")
for lib in "${libs[@]}"; do
  for prec in float double; do
    file="${lib}_${prec}.csv"
    if [ ! -f $file ]; then
      echo "matrix_size,time_mean(s),time_sd,GFLOPS_mean,GFLOPS_sd" > $file
    fi
  done
done
for i in {0..18}; do
  let size=$((2000+1000*$i))
  for lib in "${libs[@]}"; do
    for prec in float double; do
      echo -n "${size}," >> ${lib}_${prec}.csv
      ./${lib}_${prec}.x $size $size $size
    done
  done
done
cd ../../..
make clean loc=$location
module purge
