#!/bin/bash
#FLUX: --job-name=test
#FLUX: --queue=edu5
#FLUX: -t=300
#FLUX: --priority=16

echo "building active";
dtype=0
optimizer=0
make clean
make DTYPE=$dtype OPT=$optimizer
num=1
until [ $num -gt 5 ]; do
	time=1
    until [ $time -gt 3 ]; do
        #valgrind --tool=cachegrind --cache-sim=yes bin/runnable_$dtype $num >out_$num\_$time
        bin/runnable_$dtype $num >Homework_runs/no_optimization/int/out_$num\_$time\_$dtype\.txt
        time=$(($time+1))
    done
	num=$(($num+1))
done
