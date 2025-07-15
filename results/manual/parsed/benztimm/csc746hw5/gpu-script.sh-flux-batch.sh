#!/bin/bash
#FLUX: --job-name=gpu-job
#FLUX: --urgency=16

threads_per_block=("32" "64" "128" "256" "512" "1024")
num_thread_blocks=("1" "4" "16" "64" "256" "1024" "4096")
for tpb in "${threads_per_block[@]}"
do
    # Loop over each number of thread blocks
    for ntb in "${num_thread_blocks[@]}"
    do
        echo "Running with ${tpb} threads per block and ${ntb} thread blocks"
        # Run the application with ncu for profiling
        ncu --set default --section SourceCounters \
            --metrics smsp__cycles_active.avg.pct_of_peak_sustained_elapsed,dram__throughput.avg.pct_of_peak_sustained_elapsed,gpu__time_duration.avg \
            sobel_gpu $tpb $ntb
    done
done
