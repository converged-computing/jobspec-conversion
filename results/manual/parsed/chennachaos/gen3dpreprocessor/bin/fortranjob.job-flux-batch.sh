#!/bin/bash
#FLUX: --job-name="parallelfort"
#FLUX: -n=4
#FLUX: -t=18000
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/app/libraries/petsc/3.7.5/el6/AVX/intel-16.0/intel-5.1/lib'

module purge
module load hpcw
module load petsc/3.7.5
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/app/libraries/petsc/3.7.5/el6/AVX/intel-16.0/intel-5.1/lib
echo My job is started
mpirun ./partfort m6 10
echo My job has finished
