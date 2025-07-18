#!/bin/bash
#FLUX: --job-name=rand-faults-pf
#FLUX: --exclusive
#FLUX: -t=57600
#FLUX: --urgency=16

export IGNORE_CC_MISMATCH='1'

export IGNORE_CC_MISMATCH=1
module load cuda 
mem=1
cd ../../drivers/faults-NVIDIA-Linux-x86_64-460.27.04/kernel
make
sudo make modules_install
cd -
sudo rmmod nvidia-uvm
sudo modprobe nvidia-uvm #uvm_perf_prefetch_enable=0 # uvm_perf_fault_coalesce=1 #uvm_perf_fault_batch_count=1
cd ../random
make clean
make
echo "starting dev $CUDA_VISIBLE_DEVICES node $mem mem $mem"
for ((i=2**0; $i < 2**24; i=$i * 2)) do ## should be 0-20 12 - 33
    for ((j=0; j < 1; j+=1)) do
        logdir="log_pf_$(($i*4096))"
        mkdir -p $logdir
        make clean
        make DEFS=-DPNUM=$i
        sudo dmesg -C
        sudo rmmod -f nvidia-uvm
        sudo modprobe nvidia-uvm #uvm_perf_prefetch_enable=0 #uvm_perf_fault_coalesce=0 #uvm_perf_fault_batch_count=1
        file=random_$j
        logfile=/scratch1/$file
        pwd
        ../../tools/syslogger/log "$logfile" &
        pid=$!
        sleep 8
        echo "pid: $pid"
        ./page
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
        dmesg > $logdir/dmesg_$i
    done
done
sudo rmmod nvidia-uvm
sudo modprobe nvidia-uvm #uvm_perf_prefetch_enable=1 uvm_perf_fault_coalesce=1 #uvm_perf_fault_batch_count=1
