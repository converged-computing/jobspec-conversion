#!/bin/bash
#FLUX: --job-name=blue-gato-9203
#FLUX: --exclusive
#FLUX: --queue=t4_dev_q
#FLUX: -t=300
#FLUX: --urgency=16

export OMP_PROC_BIND='true'
export OMP_NUM_THREADS='32'

arrsize="1500M" #array size
module reset
module load intel
exename="stream.$arrsize"
arrsizefull="$( echo $arrsize | sed 's/M/000000/' )"
icc -o $exename stream.c -DSTATIC -DNTIMES=10 -DSTREAM_ARRAY_SIZE=$arrsizefull \
  -mcmodel=large -shared-intel -Ofast -qopenmp -ffreestanding -qopt-streaming-stores always
export OMP_PROC_BIND=true
export OMP_NUM_THREADS=32
echo "running stream benchmark on host $( hostname ) with $OMP_NUM_THREADS threads..."
echo "using $arrsize array size..."
module list
./$exename
