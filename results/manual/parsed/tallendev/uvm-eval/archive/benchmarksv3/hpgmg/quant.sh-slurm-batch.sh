#!/bin/bash
#FLUX: --job-name=hpgmg-quant
#FLUX: --exclusive
#FLUX: -t=57600
#FLUX: --urgency=16

export CUDA_MANAGED_FORCE_DEVICE_ALLOC='1'
export CUDA_VISIBLE_DEVICES='0'
export OMP_NUM_THREADS='$(($CORES/$MPI))'
export OMP_PROC_BIND='true'
export OMP_PLACES='threads'
export IFS=''

module load cuda
cd /home/tnallen/cuda11.2/NVIDIA-Linux-x86_64-460.27.04/kernel
make
sudo make modules_install
cd -
make clean
rm -rf build
./build.sh
export CUDA_MANAGED_FORCE_DEVICE_ALLOC=1
export CUDA_VISIBLE_DEVICES=0
CORES=32
MPI=1
export OMP_NUM_THREADS=$(($CORES/$MPI))
echo "OMP_NUM_THREADS=$OMP_NUM_THREADS"
export OMP_PROC_BIND=true
export OMP_PLACES=threads
oldifs=$IFS
export IFS=""
SIZES=("9 9")
name="hpgmg"
ITER=10
sudo modprobe nvidia-uvm #uvm_perf_prefetch_enable=0 
sudo rmmod nvidia-uvm
sudo modprobe nvidia-uvm #uvm_perf_prefetch_enable=0 
out="quant.csv"
rm -f $out
touch $out
for ((i=0; i < $ITER; i++)); do
    for s in ${SIZES[@]}; do
        echo "size,$s" >> $out
        val=$s
        export IFS=$oldifs
        time ./build/bin/hpgmg-fv $s | grep "alloced,\|perf,"  >> $out
        export IFS=""
        #srun  -n $MPI --cpu-bind=thread --cpus-per-task=$(($CORES/$MPI)) ./build/bin/hpgmg-fv $s 3 >> $out
    done
done
sudo rmmod nvidia-uvm
sudo modprobe nvidia-uvm #uvm_perf_prefetch_enable=0 uvm_perf_fault_coalesce=0 #uvm_perf_fault_batch_count=1
