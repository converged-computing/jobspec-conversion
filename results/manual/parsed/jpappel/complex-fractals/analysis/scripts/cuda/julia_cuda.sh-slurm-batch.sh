#!/bin/bash
#SBATCH --output=analysis/data/%x.%j.csv
#SBATCH --error=analysis/error/%x.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=gpu-shared
#SBATCH: --exclusive

THREADS=1
BLOCK_SIZE=1
square_resolutions="10 100 1000 10000 10000"
square_resolutions+=" 16 32 64 128 256 512 1024 2048 4096 8192 16384" 
for res in $square_resolutions; do
    performance_info=$(build/cuda-fractals -p -c -0.8+0.156i -r 4 -x $res -y $res -o /dev/null -f julia)
    echo "$performance_info,$THREADS,$BLOCK_SIZE"
done
