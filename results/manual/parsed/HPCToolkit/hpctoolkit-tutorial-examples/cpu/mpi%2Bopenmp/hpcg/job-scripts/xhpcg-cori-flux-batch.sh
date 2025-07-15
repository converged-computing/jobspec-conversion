#!/bin/bash
#FLUX: --job-name=grated-staircase-4661
#FLUX: -N=2
#FLUX: -c=8
#FLUX: -t=600
#FLUX: --priority=16

export OMP_NUM_THREADS='8'
export OMP_WAIT_POLICY='active'
export HPCRUN_ARGS='-o hpctoolkit-xhpcg.m -e CPUTIME -t'
export ranks='16'

module use /global/common/software/m1759/hpctoolkit-install/2021.03/modules
module load openmp/ompt
export OMP_NUM_THREADS=8
export OMP_WAIT_POLICY=active
module use /global/common/software/m3977/hpctoolkit/2021-11/modules
module load hpctoolkit/2021.11-cpu
export HPCRUN_ARGS="-o hpctoolkit-xhpcg.m -e CPUTIME -t"
export ranks=16
bind=--cpu-bind=cores 
size=32
srun -n $ranks $bind  \
    hpcrun ${HPCRUN_ARGS} build/bin/xhpcg  --nx=$size --rt=30
touch log.run.done
