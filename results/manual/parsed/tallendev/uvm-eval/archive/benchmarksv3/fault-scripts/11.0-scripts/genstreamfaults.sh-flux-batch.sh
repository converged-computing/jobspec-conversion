#!/bin/bash
#FLUX: --job-name=stream-faults
#FLUX: --exclusive
#FLUX: -t=172800
#FLUX: --urgency=16

ITERS=5
module load cuda
cd /home/tnallen/cuda11/NVIDIA-Linux-x86_64-450.51.05/kernel
make
sudo make modules_install
cd -
sudo modprobe nvidia-uvm #uvm_perf_prefetch_enable=0 #uvm_perf_fault_coalesce=0 #uvm_perf_fault_batch_count=1
sudo rmmod -f nvidia-uvm
sudo modprobe nvidia-uvm uvm_perf_prefetch_enable=0 #uvm_perf_fault_coalesce=0 #uvm_perf_fault_batch_count=1
psizes=()
if [ $# -gt 0 ]; then
    for ((i=1; i<$#+1;i++));do
        psizes+=(${!i})
    done
else
    psizes=(250001408 500002816) # 750004224)
fi
cd ../stream
for ((i=0;i<${#psizes[@]}; i++)); do
    psize=${psizes[$i]}
    make clean
    make
    logdir="log_${psize}"
    mkdir -p $logdir
    for ((j=0;j<$ITERS;j++)); do
        file=stream_$j
        logfile=/scratch1/$file
        pwd
        /home/tnallen/dev/uvm-learn/data/scripts/log "$logfile" &
        pid=$!
        sleep 8
        echo "pid: $pid"
        ./cuda-stream -n 1 -s $psize --triad-only
        len=`cat "$logfile" | wc -l`
        sleep 5
        until [ $(expr $(cat "$logfile" | wc -l)  - ${len}) -eq 0 ]; do
            len=`cat "$logfile" | wc -l`
            sleep 3
        done
        sleep 1
        kill $pid
        mv $logfile $logdir/
        ../../tools/sys2csv/log2csv.sh $logdir/$file
    done
done
cd -
sudo rmmod nvidia-uvm
sudo modprobe nvidia-uvm #uvm_perf_prefetch_enable=0 uvm_perf_fault_coalesce=0 #uvm_perf_fault_batch_count=1
