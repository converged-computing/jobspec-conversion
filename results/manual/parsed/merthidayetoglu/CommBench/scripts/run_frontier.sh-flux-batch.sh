#!/bin/bash
#FLUX: --job-name=conspicuous-chair-2022
#FLUX: -N=2
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='7'
export LD_LIBRARY_PATH='/ccs/home/merth/HiCCL/CommBench/aws-ofi-rccl/lib:$LD_LIBRARY_PATH'
export NCCL_NET_GDR_LEVEL='3'

module -t list
date
export OMP_NUM_THREADS=7
export LD_LIBRARY_PATH=/ccs/home/merth/HiCCL/CommBench/aws-ofi-rccl/lib:$LD_LIBRARY_PATH
export NCCL_NET_GDR_LEVEL=3
warmup=5
numiter=10
for library in 2
do
for pattern in 1
do
for direction in 0
do
for n in 2
do
for g in 8
do
for k in 8
do
count=$((2 ** 24))
  srun -c7 ./CommBench $library $pattern $direction $count $warmup $numiter $n $g $k
done
done
done
done
done
done
date
