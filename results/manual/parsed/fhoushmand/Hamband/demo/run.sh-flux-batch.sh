#!/bin/bash
#FLUX: --job-name=peachy-train-1468
#FLUX: -N=4
#FLUX: -n=4
#FLUX: -c=4
#FLUX: --exclusive
#FLUX: --queue=short
#FLUX: --urgency=16

module load valgrind;
nodes=($( scontrol show hostnames $SLURM_NODELIST ))
nnodes=${#nodes[@]}
last=$(( $nnodes - 1 ))
DORY_HOME="/rhome/fhous001/farzin/FastChain/dory/demo"
hostlist=""
for i in $( seq 0 $last ); do
        hostlist+="${nodes[$i]} "
done
echo $hostlist
ssh ${nodes[0]}.ib.hpcc.ucr.edu 'cd ${DORY_HOME}; memcached -vv -p 9999'&
sleep 5;
for i in $( seq 1 $last ); do
        #printf "ssh ${nodes[$i]}.ib.hpcc.ucr.edu 'cd ${DORY_HOME}; export DORY_REGISTRY_IP=${nodes[0]}:9999; numactl --membind 0 ./crash-consensus/demo/using_conan_fully/build/bin/main-st $i 4096 1 > $i.log'"
        ssh ${nodes[$i]}.ib.hpcc.ucr.edu "cd ${DORY_HOME}; export DORY_REGISTRY_IP=${nodes[0]}:9999; numactl --membind 0 ./build/bin/dorydemo $i > $i.log &"
done
sleep 60
