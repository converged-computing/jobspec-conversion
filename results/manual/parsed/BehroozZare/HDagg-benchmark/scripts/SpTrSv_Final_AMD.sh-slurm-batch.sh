#!/bin/bash
#FLUX: --job-name=SpTrSv_Final
#FLUX: -t=21600
#FLUX: --urgency=16

export OMP_NUM_THREADS='64'
export MKL_NUM_THREADS='64'

source init_var.sh
export OMP_NUM_THREADS=64
export MKL_NUM_THREADS=64
SOURCE_DIR=$(pwd)
echo "Start SpTrSv Final"
cd ${SOURCE_DIR}/build/example
rm -rf SpTrSv_Final_20.csv
for sparse_mat in matrix/*.mtx;
do
    echo "Processing ${sparse_mat}"
    ./SpTrSv_Final ${sparse_mat}
done
