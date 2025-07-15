#!/bin/bash
#FLUX: --job-name=red-egg-3448
#FLUX: --exclusive
#FLUX: --urgency=16

export IGNORE_CC_MISMATCH='1'

export IGNORE_CC_MISMATCH=1
ITERS=1
module load cuda
sudo modprobe nvidia-uvm #uvm_perf_prefetch_enable=0 #uvm_perf_fault_coalesce=0 #uvm_perf_fault_batch_count=1
sudo rmmod -f nvidia-uvm
sudo modprobe nvidia-uvm uvm_perf_prefetch_enable=0 #uvm_perf_fault_coalesce=0 #uvm_perf_fault_batch_count=1
cd ../../tools/syslogger/
make
cd -
bsizes=(256)
psizes=()
if [ $# -gt 0 ]; then
    for ((i=1; i<$#+1;i++));do
        psizes+=(${!i})
    done
else
    #psizes=($(expr 4096 \* 4))
    #psizes=($(expr 4096 \* 4) $(expr 4096 \* 8))
    psizes=(22000000)
    #psizes=(10000000 20000000 22000000)
    #psizes=( 256 )
fi
cd ../gauss-seidel
./build.sh
rm -f quant*.csv
find . -maxdepth 1  -name 'log_*' -type d -exec rm -rf {} +
cd ../../drivers/x86_64-460.27.04/batchd/kernel
make -j
sudo make modules_install
cd -
for ((pf=0; pf < 2; pf++)); do
    # iter batch sizes
    for ((k=0; k<${#bsizes[@]}; k++)); do
        bsize=${bsizes[$k]}
        # iter problem size
        for ((i=0;i<${#psizes[@]}; i++)); do
            psize=${psizes[$i]}
            if [ $pf -eq 1 ]; then
                logdir="log_pf_${psize}_bsize_${bsizes[$k]}"
            else 
                logdir="log_${psize}_bsize_${bsizes[$k]}"
            fi
            mkdir -p $logdir
            # if want more than one sample per problem size
            for ((j=0;j<$ITERS;j++)); do
                sudo dmesg -C
                sudo rmmod -f nvidia-uvm
                sudo modprobe nvidia-uvm uvm_perf_prefetch_enable=${pf} uvm_perf_fault_batch_count=${bsizes[$k]}   #uvm_perf_fault_coalesce=0 #uvm_perf_fault_batch_count=1
                if [ $pf -eq 1 ]; then
                    out="quant-pf-${bsize}.csv"
                else
                    out="quant-${bsize}.csv"
                fi
                echo "size,$psize" >> $out 
                file=gauss-seidel_$j
                logfile=/scratch1/$file
                pwd
                ../../tools/syslogger/log "$logfile" &
                pid=$!
                sleep 8
                echo "pid: $pid"
                nvprof -u s ./gs ${psize} &>> $out #| grep "alloced,\|perf," >> $out
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
    done
done
cd -
sudo rmmod nvidia-uvm
sudo modprobe nvidia-uvm #uvm_perf_prefetch_enable=0 uvm_perf_fault_coalesce=0 #uvm_perf_fault_batch_count=1
echo "done"
