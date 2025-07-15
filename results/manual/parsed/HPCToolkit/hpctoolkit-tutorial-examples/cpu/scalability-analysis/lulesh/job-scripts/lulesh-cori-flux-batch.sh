#!/bin/bash
#FLUX: --job-name=rainbow-latke-7630
#FLUX: -c=64
#FLUX: -t=300
#FLUX: --urgency=16

export OMP_PROC_BIND='true'
export OMP_PLACES='threads'
export OMP_WAIT_POLICY='active'
export OMP_NUM_THREADS='32'
export HPCRUN_ARGS='-o hpctoolkit-lulesh-${OMP_NUM_THREADS}.m -e CPUTIME -t'

module use /global/common/software/m1759/hpctoolkit-install/2021.03/modules
module load openmp/ompt
  module use /global/common/software/m3977/hpctoolkit/2021-11/modules
  module load hpctoolkit/2021.11-cpu
export OMP_PROC_BIND=true
export OMP_PLACES=threads
export OMP_WAIT_POLICY=active
bind=--cpu-bind=cores 
export OMP_NUM_THREADS=16
export HPCRUN_ARGS="-o hpctoolkit-lulesh-${OMP_NUM_THREADS}.m -e CPUTIME -t"
srun -n 1 $bind  \
    hpcrun ${HPCRUN_ARGS} lulesh/lulesh2.0
export OMP_NUM_THREADS=32
export HPCRUN_ARGS="-o hpctoolkit-lulesh-${OMP_NUM_THREADS}.m -e CPUTIME -t"
srun -n 1 $bind  \
    hpcrun ${HPCRUN_ARGS} lulesh/lulesh2.0
touch log.run.done
