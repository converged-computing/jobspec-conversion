#!/bin/bash
#SBATCH --output=EPYC_7H12.out
#SBATCH --error=EPYC_7H12.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2048
#SBATCH --time=00:01:00
#SBATCH --constraint=EPYC_7H12

module load gcc # load a compiler (gcc/11.4.0)
gcc -O3 -march=native -DSTREAM_TYPE=double -DSTREAM_ARRAY_SIZE=20000000 \
-DNTIMES=20 stream.c -o stream_c.exe # compile
./stream_c.exe
