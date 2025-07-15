#!/bin/bash
#FLUX: --job-name=RT-serial
#FLUX: -t=3000
#FLUX: --urgency=16

module purge > /dev/null 2>&1
module load cmake mpi/intel
COMPILER=`gcc --version |head -1`
COMPILER=`icc --version |head -1`
TEMP=`lscpu|grep "Model name:"`
IFS=':' read -ra CPU_MODEL <<< "$TEMP"
width=2048
height=2048
if [ ! -f timing.csv ];
then
    echo "CPU,Parallelisation,Number of threads/processes per node,Number of nodes,Compiler,Image size,Runtime in sec" > timing.csv
fi
/usr/bin/time --format='%e' ./bin/main --size $width $height --jpeg serial-${width}x$height.jpg 2> temp-serial
RUNTIME=`cat temp-serial`
echo ${CPU_MODEL[1]},None,0,1,$COMPILER,${width}x$height,$RUNTIME >> timing-serial.csv
