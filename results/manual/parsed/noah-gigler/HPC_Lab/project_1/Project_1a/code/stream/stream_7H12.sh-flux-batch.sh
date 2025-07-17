#!/bin/bash
#FLUX: --job-name=sticky-bicycle-9455
#FLUX: -t=60
#FLUX: --urgency=16

module load gcc # load a compiler (gcc/11.4.0)
gcc -O3 -march=native -DSTREAM_TYPE=double -DSTREAM_ARRAY_SIZE=20000000 \
-DNTIMES=20 stream.c -o stream_c.exe # compile
./stream_c.exe
