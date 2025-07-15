#!/bin/bash
#FLUX: --job-name=cloverleaf_ws_test
#FLUX: --exclusive
#FLUX: --queue=
#FLUX: -t=300
#FLUX: --urgency=16

num_gpus=$1
nodes=$2
executable=$3
path=$4
num_runs=$5
size=$(( $num_gpus*32 )) #TODO: change this 32 depending on the max size on a single GPU
mpirun -n $num_gpus -gpu ./${executable} --file $path/cloverleaf_sycl/input_file/clover_bm${size}_short.in 2>> $path/cloverleaf_sycl/logs_${num_gpus}gpus_${nodes}nodes_${num_runs}runs/${executable} 
