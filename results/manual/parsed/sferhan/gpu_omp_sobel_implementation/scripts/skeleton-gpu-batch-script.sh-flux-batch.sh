#!/bin/bash
#FLUX: --job-name=gpu-job
#FLUX: --priority=16

ncu --set default --section SourceCounters --metrics smsp__cycles_active.avg.pct_of_peak_sustained_elapsed,dram__throughput.avg.pct_of_peak_sustained_elapsed,gpu__time_duration.avg ./sobel_cpu_omp_offload
