#!/bin/bash
#FLUX: --job-name=persnickety-bicycle-8482
#FLUX: -n=64
#FLUX: --exclusive
#FLUX: --queue=compute
#FLUX: --urgency=16

export PATH='/shared/openmpi-4.1.4-acfl/bin:$PATH'
export LD_LIBRARY_PATH='/shared/openmpi-4.1.4-acfl/lib:$LD_LIBRARY_PATH'
export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'
export FI_EFA_FORK_SAFE='1'

export PATH=/shared/gromacs-2022.4-acfl/bin:$PATH
export LD_LIBRARY_PATH=/shared/gromacs-2022.4-acfl/lib:$LD_LIBRARY_PATH
export PATH=/shared/openmpi-4.1.4-acfl/bin:$PATH
export LD_LIBRARY_PATH=/shared/openmpi-4.1.4-acfl/lib:$LD_LIBRARY_PATH
module use /shared/arm/modulefiles
module load acfl armpl
[ ! -d /shared/data-gromacs/benchRIB ] && mkdir -p /shared/data-gromacs/benchRIB
cd /shared/data-gromacs/benchRIB
bench=RIB
if [ ! -f bench${bench} ]; then
  wget https://www.mpinat.mpg.de/bench${bench}
  unzip bench${bench}
fi
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export FI_EFA_FORK_SAFE=1
echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
mpirun -np ${SLURM_NTASKS} --report-bindings gmx_mpi mdrun -v -maxh 0.25 -deffnm bench${bench} -ntomp ${OMP_NUM_THREADS} -resethway &>> bench${bench}.out
