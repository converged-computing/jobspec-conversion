#!/bin/bash
#FLUX: --job-name=benchmark
#FLUX: --exclusive
#FLUX: --queue=lva
#FLUX: --priority=16

rm -f results.csv
data_structures=("Array" "LinkedList")
ins_del_ratios=(0 1 10 50)
read_write_ratios=(100 99 90 50)
element_sizes=(8 512 8192)
num_elements=(10 1000 100000 10000000)
gcc -O3 -o Array array_bench.c
gcc -O3 -o LinkedList linked_list_bench.c
test_sequence=1
echo "idx, data structure, Ins/Del Ratio,Read/Write Ratio,Element Size,Number of Elements,Operations Completed, Time[Seconds]" >> results.csv
for ds in ${data_structures[@]}; do
    for idr in ${ins_del_ratios[@]}; do
        for rwr in ${read_write_ratios[@]}; do
            for es in ${element_sizes[@]}; do
                for ne in ${num_elements[@]}; do
                    # Print the arguments
                    echo "Arguments: $ds $idr $rwr $es $ne"
                    # Run the benchmark and save the output to a file
                    echo -n "$test_sequence,$ds,$idr,$rwr,$es,$ne," >> results.csv
                    ./$ds $idr $rwr $es $ne >> results.csv
                    ((test_sequence++))
                done
            done
        done
    done
done
