#!/bin/bash
#FLUX: --job-name=bricky-gato-5441
#FLUX: -N=2
#FLUX: -c=16
#FLUX: -t=300
#FLUX: --urgency=16

export OMP_PROC_BIND='true'
export OMP_PLACES='threads'
export OMP_NUM_THREADS='16'
export OMP_WAIT_POLICY='active'
export HPCRUN_ARGS='-o hpctoolkit-amg2013.m -e CPUTIME -t'
export ranks='16'

module use /global/common/software/m3977/modulefiles/perlmutter
module load hpctoolkit/default
export OMP_PROC_BIND=true
export OMP_PLACES=threads
export OMP_NUM_THREADS=16
export OMP_WAIT_POLICY=active
export HPCRUN_ARGS="-o hpctoolkit-amg2013.m -e CPUTIME -t"
export ranks=16
bind=--cpu-bind=cores 
refine=20
srun -n $ranks $bind  \
    hpcrun ${HPCRUN_ARGS} AMG2013/test/amg2013  -P 2 4 2  -r  $refine $refine $refine
