#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --exclusive

export OMP_PROC_BIND='true'
export OMP_NUM_THREADS='32'
export OMP_PLACES='$( seq -s },{ 0 4 127 | sed -e 's/\(.*\)/\{\1\}/' )'

arrsize="2500M" #array size
module reset
module load intel
exename="stream.$arrsize"
arrsizefull="$( echo $arrsize | sed 's/M/000000/' )"
icc -o $exename stream.c -DSTATIC -DNTIMES=10 -DSTREAM_ARRAY_SIZE=$arrsizefull \
  -mcmodel=large -shared-intel -Ofast -qopenmp -ffreestanding -qopt-streaming-stores always
export OMP_PROC_BIND=true
export OMP_NUM_THREADS=32
export OMP_PLACES="$( seq -s },{ 0 4 127 | sed -e 's/\(.*\)/\{\1\}/' )"
echo "running stream benchmark on host $( hostname ) with $OMP_NUM_THREADS threads..."
echo "using $arrsize array size..."
module list
./$exename
