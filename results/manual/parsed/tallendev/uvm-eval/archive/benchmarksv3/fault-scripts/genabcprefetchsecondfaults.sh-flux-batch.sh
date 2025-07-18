#!/bin/bash
#FLUX: --job-name=abc-prefetch-second-faults
#FLUX: --exclusive
#FLUX: -t=172800
#FLUX: --urgency=16

export IGNORE_CC_MISMATCH='1'

export IGNORE_CC_MISMATCH=1
ITERS=5
module load cuda
cd ../../drivers/faults-NVIDIA-Linux-x86_64-460.27.04/kernel
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
    psizes=(32 128 256 1024 2048)
fi
cd ../abc-prefetch-second
for ((i=0;i<${#psizes[@]}; i++)); do
    psize=${psizes[$i]}
    make clean
    make DEFS="-DTSIZE=$psize -DBSIZE=$psize"
    logdir="log_${psize}"
    mkdir -p $logdir
    for ((j=0;j<$ITERS;j++)); do
        file=abc_$j
        logfile=/scratch1/$file
        pwd
        sudo dmesg -C
        ../../tools/syslogger/log "$logfile" &
        pid=$!
        sleep 8
        echo "pid: $pid"
        time ./abc
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
