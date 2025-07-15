#!/bin/bash
#FLUX: --job-name=sym
#FLUX: -c=40
#FLUX: --urgency=16

export MKLROOT='/scinet/intel/2019u3/compilers_and_libraries_2019/linux/mkl'
export OMP_NUM_THREADS='$THRDS'
export MKL_NUM_THREADS='$THRDS'

module load NiaEnv/2019b
module load cmake/3.17.3
module load intel
module load intel/2019u3
module load intel
module load gcc
module load mkl
module load metis/5.1.0
module load gcc/9.4.0 
export MKLROOT=/scinet/intel/2019u3/compilers_and_libraries_2019/linux/mkl
THRDS=20
export OMP_NUM_THREADS=$THRDS
export MKL_NUM_THREADS=$THRDS
cmake -DCMAKE_PREFIX_PATH="/scinet/intel/2019u3/compilers_and_libraries_2019/linux/mkl/lib/intel64/;/scinet/intel/2019u3/compilers_and_libraries_2019/linux/mkl/include/;"  -DCMAKE_BUILD_TYPE=Release ..
make -j 20
for f in $(find /scratch/m/mmehride/kazem/dlmc -name '*.smtx'); do 
  echo $f;
  /scratch/m/mmehride/kazem/development/DDT/build/demo/spmm_demo --matrix $f --numerical_operation SPMM --storage_format CSR --n_tile_size=32 --b_matrix_columns=32 -t $THRDS >> spmm_32.csv
done
for f in $(find /scratch/m/mmehride/kazem/dlmc -name '*.smtx'); do 
  echo $f;
  /scratch/m/mmehride/kazem/development/DDT/build/demo/spmm_demo --matrix $f --numerical_operation SPMM --storage_format CSR --n_tile_size=64 --b_matrix_columns=64 -t $THRDS >> spmm_64.csv
done
for f in $(find /scratch/m/mmehride/kazem/dlmc -name '*.smtx'); do 
  echo $f;
  /scratch/m/mmehride/kazem/development/DDT/build/demo/spmm_demo --matrix $f --numerical_operation SPMM --storage_format CSR --n_tile_size=128 --b_matrix_columns=128 -t $THRDS >> spmm_128.csv
done
