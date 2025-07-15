#!/bin/bash
#FLUX: --job-name="swbench"
#FLUX: -c=40
#FLUX: --priority=16

THREADS=20
module load NiaEnv/.2022a
module load intel/2022u2
module load mkl/2022u2
module load cmake
module load gcc
echo "---- running an example ----"
cd build
rm ../results_spmm.csv
sizes="128 256 512 1024 2048"
thread_list="1"
HEADER="ON"
BLOCKSIZE=16
for size in $sizes; do
  # shellcheck disable=SC2034
  for thr in $thread_list;do
  export MKL_NUM_THREADS=$thr
  if [ "$HEADER" == "ON" ]; then
    ./DemoSpMM "$thr" "$size" 1
    HEADER="OFF"
  else
    ./DemoSpMM "$thr" "$size" 0
  fi
  done
done
done
