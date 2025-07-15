#!/bin/bash
#FLUX: --job-name="ex2"
#FLUX: --exclusive
#FLUX: --queue=EPYC
#FLUX: -t=7200
#FLUX: --priority=16

export LD_LIBRARY_PATH='/u/dssc/galess00/final_assignment_FHPC/exercise2/myblis_epyc/lib:$LD_LIBRARY_PATH'
export OMP_PLACES='cores'
export OMP_PROC_BIND='$policy'

echo "loading modules"
module load architecture/AMD
module load mkl
module load openBLAS/0.3.23-omp
export LD_LIBRARY_PATH=/u/dssc/galess00/final_assignment_FHPC/exercise2/myblis_epyc/lib:$LD_LIBRARY_PATH
location=$(pwd)
cd ../../..
make clean loc=$location
make cpu loc=$location
size=10000
cd $location
policy=spread
arch=EPYC #architecture
export OMP_PLACES=cores
export OMP_PROC_BIND=$policy
libs=("blis")
for lib in "${libs[@]}"; do
  for prec in float double; do
    file="${lib}_${prec}.csv"
    if [ ! -f $file ]; then
     echo "#cores,time_mean(s),time_sd,GFLOPS_mean,GFLOPS_sd" > $file
    fi
  done
done
for cores in $(seq 2 2 128)
do
  export OMP_NUM_THREADS=$cores
  for lib in "${libs[@]}"; do
    for prec in float double; do
      echo -n "${cores}," >> ${lib}_${prec}.csv
      ./${lib}_${prec}.x $size $size $size
    done
  done
done
cd ../../..
make clean loc=$location
module purge
