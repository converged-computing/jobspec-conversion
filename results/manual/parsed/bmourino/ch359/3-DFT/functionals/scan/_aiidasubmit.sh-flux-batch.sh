#!/bin/bash
#FLUX: --job-name=<your-job-name>
#FLUX: -t=28800
#FLUX: --urgency=16

module load intel
module load gcc/11.3.0
module load openmpi/4.1.3
module load cp2k/9.1-mpi-openmp
'srun' '-n' '36' '/ssoft/spack/syrah/v1/opt/spack/linux-rhel8-skylake_avx512/gcc-11.3.0/cp2k-9.1-klrakkis7sb24thlwnxd7slve3qwspxm/bin/cp2k.popt' '-i' 'aiida.inp'  > 'aiida.out' 2>&1
