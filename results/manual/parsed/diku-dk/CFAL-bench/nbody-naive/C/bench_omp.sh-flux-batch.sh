#!/bin/bash
#FLUX: --job-name=spicy-noodle-3538
#FLUX: -c=32
#FLUX: --queue=csmpi_fpga_long
#FLUX: -t=14400
#FLUX: --priority=16

export XILINX_XRT='/opt/xilinx/xrt'

export XILINX_XRT=/opt/xilinx/xrt
if [ "$#" -ne 5 ]; then
    printf 'Usage: run.sh N ITERATIONS RUNS OUT_DIR P\n\n' >&2
    printf '\tN: Number of bodies\n\n' >&2
    printf '\tITERATIONS: Number of advancements in the benchmark\n\n' >&2
    printf '\tRUNS: How often to run the benchmark\n\n' >&2
    printf '\tOUT_DIR: Directory to store benchmark results\n\n' >&2
    printf '\tP: Number of processors to use\n\n' >&2
    exit 1
fi
n="$1"
iter="$2"
runs="$3"
outfile="$4/nbody_${n}_${iter}_omp_C"
pmax="$5"
mkdir -p "$4"
make clean
make -j
printf 'p,mean,stddev\n' > "${outfile}"
p=1
while [ $p -le "$pmax" ]
do
    printf '%d,' "$p" >> "${outfile}"
    {
        i=1
        while [ $i -le "$runs" ]
        do
            OMP_NUM_THREADS="$p" ./nbody_omp "$n" "$iter"
            i=$(( i + 1 ))
        done
    } | variance >> "${outfile}"
    p=$(( 2 * p ))
done
