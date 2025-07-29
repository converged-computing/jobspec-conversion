#!/bin/bash
#SBATCH --job-name=RT-serial
#SBATCH --account=scw1563
#SBATCH --output=ray_tracing-%j.out
#SBATCH --error=ray_tracing-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=600mb
#SBATCH --time=00:50:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --exclude=ccs[2103-2114]

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
