#!/bin/bash
#FLUX: --job-name=s_try
#FLUX: -N=4
#FLUX: -t=1200
#FLUX: --urgency=16

export PATH='/home/hpc/b154dc/b154dc23/QE/qe-intel/qe-7.2/build-elpa/bin:$PATH'

export PATH=/home/hpc/b154dc/b154dc23/QE/qe-intel/qe-7.2/build-elpa/bin:$PATH
source /home/hpc/b154dc/b154dc23/spack/share/spack/setup-env.sh
spack load intel-oneapi-mkl%gcc
spack load intel-oneapi-mpi
_module_raw ()
{
    eval `/usr/bin/tclsh /apps/modules/modulecmd.tcl bash "$@"`;
    _mlstatus=$?;
    return $_mlstatus
}
module ()
{
    _module_raw "$@" 2>&1
}
mpiexec -n 288 -ppn 72 -genv I_MPI_PIN_DOMAIN=socket -genv I_MPI_PIN_ORDER=spread cp.x -pd .true. -inp cp.in
