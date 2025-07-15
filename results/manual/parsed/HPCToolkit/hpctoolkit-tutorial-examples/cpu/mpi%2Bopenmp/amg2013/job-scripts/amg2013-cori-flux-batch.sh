#!/bin/bash
#FLUX: --job-name=eccentric-frito-3738
#FLUX: -N=2
#FLUX: -c=8
#FLUX: -t=300
#FLUX: --priority=16

export OMP_PROC_BIND='true'
export OMP_PLACES='threads'
export OMP_NUM_THREADS='8'
export OMP_WAIT_POLICY='active'
export HPCRUN_ARGS='-o hpctoolkit-amg2013.m -e CPUTIME -t'
export ranks='16'

module use /global/common/software/m1759/hpctoolkit-install/2021.03/modules
module load openmp/ompt
module use /global/common/software/m3977/hpctoolkit/2021-11/modules
module load hpctoolkit/2021.11-cpu
export OMP_PROC_BIND=true
export OMP_PLACES=threads
export OMP_NUM_THREADS=8
export OMP_WAIT_POLICY=active
export HPCRUN_ARGS="-o hpctoolkit-amg2013.m -e CPUTIME -t"
export ranks=16
bind=--cpu-bind=cores 
refine=20
srun -n $ranks $bind  \
    hpcrun ${HPCRUN_ARGS} AMG2013/test/amg2013  -P 2 4 2  -r  $refine $refine $refine
touch log.run.done
