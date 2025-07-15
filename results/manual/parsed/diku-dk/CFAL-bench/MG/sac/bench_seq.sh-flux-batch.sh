#!/bin/bash
#FLUX: --job-name=chunky-bits-6586
#FLUX: -c=32
#FLUX: --queue=csmpi_fpga_long
#FLUX: -t=14400
#FLUX: --urgency=16

export XILINX_XRT='/opt/xilinx/xrt'

export XILINX_XRT=/opt/xilinx/xrt
if [ "$#" -ne 3 ]; then
    printf 'Usage: run.sh CLASS RUNS OUT_DIR\n\n' >&2
    printf '\tCLASS: Problem class (S, A, B, C, D)\n\n' >&2
    printf '\tRUNS: How often to run the benchmark\n\n' >&2
    printf '\tOUT_DIR: Directory to store benchmark results.\n\n' >&2
    exit 1
fi
class="$1"
runs="$2"
outfile="$3/MG_${class}_seq_sac"
mkdir -p "$3"
make CLASS="$class" seq
{
printf 'p,mean,stddev\n'
printf '1,'
} > "$outfile"
i=1
{
while [ $i -le "$runs" ]
do
    bin/MG_"${class}"_seq
    i=$(( i + 1 ))
done
} | variance >> "$outfile"
