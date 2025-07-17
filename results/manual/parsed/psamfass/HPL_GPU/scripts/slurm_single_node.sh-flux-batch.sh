#!/bin/bash
#FLUX: --job-name=hpl
#FLUX: --exclusive
#FLUX: --queue=MI250
#FLUX: -t=600
#FLUX: --urgency=16

export AMD_LOG_LEVEL='1'

module load openblas
module load mpi/ompi-4.1.x
hpl_runscript=./run_xhplhip.sh
cp ../scripts/config/HPL_1GPU.dat HPL.dat
filename=HPL.dat
P=$(sed -n "11, 1p" ${filename} | awk '{print $1}')
Q=$(sed -n "12, 1p" ${filename} | awk '{print $1}')
np=$(($P*$Q))
echo ${np}
num_cpu_cores=$(lscpu | grep "Core(s)" | awk '{print $4}')
num_cpu_sockets=$(lscpu | grep Socket | awk '{print $2}')
total_cpu_cores=$(($num_cpu_cores*$num_cpu_sockets))
mpi_args="--map-by slot:PE=${total_cpu_cores} --bind-to core:overload-allowed --mca btl ^openib --mca pml ucx --report-bindings -x LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/rocm/lib ${mpi_args}"
export AMD_LOG_LEVEL=1
mpirun -n ${np} ${mpi_args} ${hpl_runscript} # choose appropriate affinity settings for MPI here
