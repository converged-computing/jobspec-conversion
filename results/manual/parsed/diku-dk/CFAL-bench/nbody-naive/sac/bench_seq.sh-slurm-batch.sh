#!/bin/bash
#SBATCH --account=csmpi
#SBATCH --output=seq.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:nvidia_a30:1
#SBATCH --mem=64G
#SBATCH --time=04:00:00
#SBATCH --partition=csmpi_fpga_long

export XILINX_XRT='/opt/xilinx/xrt'

export XILINX_XRT=/opt/xilinx/xrt
if [ "$#" -ne 4 ]; then
    printf 'Usage: run.sh N ITERATIONS RUNS OUT_DIR\n\n' >&2
    printf '\tN: Number of bodies\n\n' >&2
    printf '\tITERATIONS: Number of advancements in the benchmark\n\n' >&2
    printf '\tRUNS: How often to run the benchmark\n\n' >&2
    printf '\tOUT_DIR: Directory to store benchmark results.\n\n' >&2
    exit 1
fi
n="$1"
iter="$2"
runs="$3"
outfile="$4/nbody_${n}_${iter}_seq_sac"
mkdir -p "$4"
make clean
make N="$n" ITER="$iter" -j2
{
printf 'p,mean,stddev\n'
printf '1,'
} > "$outfile"
i=1
{
while [ $i -le "$runs" ]
do
    bin/nbody_seq "$n" "$iter"
    i=$(( i + 1 ))
done
} | variance >> "$outfile"
