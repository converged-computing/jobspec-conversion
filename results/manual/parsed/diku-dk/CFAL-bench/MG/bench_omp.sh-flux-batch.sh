#!/bin/bash
#FLUX: --job-name=blank-hobbit-0817
#FLUX: -c=32
#FLUX: --queue=csmpi_fpga_long
#FLUX: -t=14400
#FLUX: --urgency=16

export XILINX_XRT='/opt/xilinx/xrt'

export XILINX_XRT=/opt/xilinx/xrt
if [ "$#" -ne 3 ]; then
    printf 'Usage: sbatch bench_omp.sh CLASS RUNS OUT_DIR\n\n' >&2
    printf '\tCLASS: Problem class (S, W, A, B, C, D) \n\n' >&2
    printf '\tRUNS: How often to run the benchmark\n\n' >&2
    printf '\tOUT_DIR: Directory to store benchmark results\n\n' >&2
    exit 1
fi
class="$1"
runs="$2"
outfile="$3/MG_${class}_omp_fortran"
pmax="$4"
mkdir -p "$3"
make mg CLASS="$class" 
printf 'mean,stddev\n' > "${outfile}"
p=32
{
    i=1
    while [ $i -le "$runs" ]
    do
        OMP_NUM_THREADS="$p" "bin/mg.${class}.x"
        i=$(( i + 1 ))
    done
} | grep Mop\/s\ total | grep -o '[0-9.]*' | \
    awk '{print $1/1000}' /dev/stdin | variance >> "$outfile"
