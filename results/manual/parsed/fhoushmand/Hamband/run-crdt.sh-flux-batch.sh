#!/bin/bash
#FLUX: --job-name=outstanding-peanut-2493
#FLUX: -N=8
#FLUX: -n=8
#FLUX: -c=8
#FLUX: --exclusive
#FLUX: --queue=short
#FLUX: --urgency=16

nodes=($( scontrol show hostnames $SLURM_NODELIST ))
nnodes=${#nodes[@]}
last=$(( $nnodes - 1 ))
DORY_HOME="/rhome/fhous001/farzin/FastChain/dory"
RESULT_LOC="/rhome/fhous001/farzin/FastChain/dory/wellcoordination/workload/"
NUM_OPS=$1
REP=$2 # number of reps
USECASE=$3 # name of the usecase: account, courseware, gset, counter
if [ "$#" -ne 3 ]; then
    echo "Illegal number of parameters"
fi
hostlist=""
for i in $( seq 0 $last ); do
        hostlist+="${nodes[$i]} "
done
echo $hostlist
PERCENTAGES="5 15 25";
MODE=mu
for n in $( seq 3 7 ); do
        for p in $PERCENTAGES; do
                BENCH_DIRECTORY=$RESULT_LOC$n-$NUM_OPS-$p/$USECASE;
                if [ ! -d "$BENCH_DIRECTORY" ]; then
                        mkdir -p $BENCH_DIRECTORY;
                        /rhome/fhous001/farzin/FastChain/dory/wellcoordination/src/$USECASE-benchmark.out $n $NUM_OPS $p;
                        echo "benchmark generated";
                fi
                mkdir -p $BENCH_DIRECTORY/results;
                for r in $( seq $REP $REP ); do
                        #printf "ssh ${nodes[0]}.ib.hpcc.ucr.edu 'cd ${DORY_HOME}; memcached -vv -p 9999'"
                        ssh ${nodes[0]}.ib.hpcc.ucr.edu 'memcached -vv -p 9999'&
                        sleep 2;
                        for i in $( seq 1 $n ); do
                                #printf "ssh ${nodes[$i]}.ib.hpcc.ucr.edu 'cd ${DORY_HOME}; export DORY_REGISTRY_IP=${nodes[0]}:9999; numactl --membind 0 ./crash-consensus/demo/using_conan_fully/build/bin/main-st $i 4096 1 > $i.log'"
                                #ssh ${nodes[$i]}.ib.hpcc.ucr.edu "cd ${DORY_HOME}; export DORY_REGISTRY_IP=${nodes[0]}:9999; numactl --membind 0 ./wellcoordination/build/bin/band 2 $i 10000 10 > $i.log&"
                                printf "ssh ${nodes[$i]}.ib.hpcc.ucr.edu 'cd ${DORY_HOME}; export DORY_REGISTRY_IP=${nodes[0]}:9999; numactl --membind 0 ./wellcoordination/build/bin/$MODE $i $n $NUM_OPS $p $USECASE > $RESULT_LOC$n-$NUM_OPS-$p/$USECASE/results/$MODE-$i-$r.log'\n";
                                ssh ${nodes[$i]}.ib.hpcc.ucr.edu "cd ${DORY_HOME}; export DORY_REGISTRY_IP=${nodes[0]}:9999; numactl --membind 0 ./wellcoordination/build/bin/$MODE $i $n $NUM_OPS $p $USECASE > $RESULT_LOC$n-$NUM_OPS-$p/$USECASE/results/$MODE-$i-$r.log&";
                        done
                        sleep 30;
                        ssh ${nodes[0]}.ib.hpcc.ucr.edu "bash -s" <./kill-memcached.sh
                        sleep 2;
                done
                ssh ${nodes[0]}.ib.hpcc.ucr.edu "bash -s" <./kill-memcached.sh
                sleep 2;
        done
        ssh ${nodes[0]}.ib.hpcc.ucr.edu "bash -s" <./kill-memcached.sh
        sleep 2;        
done
sleep 120
