#!/bin/bash
#FLUX: --job-name=placid-caramel-2082
#FLUX: --exclusive
#FLUX: --priority=16

export CUDA_MANAGED_FORCE_DEVICE_ALLOC='1'
export CUDA_VISIBLE_DEVICES='0'
export OMP_NUM_THREADS='$(($CORES/$MPI))'
export OMP_PROC_BIND='true'
export OMP_PLACES='threads'

module load gcc cuda
./build.sh
export CUDA_MANAGED_FORCE_DEVICE_ALLOC=1
export CUDA_VISIBLE_DEVICES=0
CORES=32
MPI=1
export OMP_NUM_THREADS=$(($CORES/$MPI))
echo "OMP_NUM_THREADS=$OMP_NUM_THREADS"
export OMP_PROC_BIND=true
export OMP_PLACES=threads
SIZES=(2 4 6 8 10 12 14 16 18 20)
right_now_string=`date +%Y_%m_%d__%H_%M_%S`
name="hpgmg"
ITER=1
sudo rmmod nvidia-uvm
sudo modprobe nvidia-uvm 
out="quant2.csv"
echo "" > $out
for ((i=0; i < $ITER; i++)); do
    for s in ${SIZES[@]}; do
        echo "size,$s" >> $out
        time ./build/bin/hpgmg-fv  9 $s | grep "alloced,\|time," >> $out
        #srun  -n $MPI --cpu-bind=thread --cpus-per-task=$(($CORES/$MPI)) ./build/bin/hpgmg-fv $s 3 >> $out
    done
done
sudo rmmod nvidia-uvm
sudo modprobe nvidia-uvm uvm_perf_prefetch_enable=0 
out="quant2-nopref.csv"
echo "" > $out
for ((i=0; i < $ITER; i++)); do
    for s in ${SIZES[@]}; do
        echo "size,$s" >> $out
        time ./build/bin/hpgmg-fv 7 $s | grep "alloced,\|time,"  >> $out
        #srun  -n $MPI --cpu-bind=thread --cpus-per-task=$(($CORES/$MPI)) ./build/bin/hpgmg-fv $s 3 >> $out
    done
done
sudo rmmod nvidia-uvm
sudo modprobe nvidia-uvm #uvm_perf_prefetch_enable=0 uvm_perf_fault_coalesce=0 #uvm_perf_fault_batch_count=1
