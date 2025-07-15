#!/bin/bash
#FLUX: --job-name=strawberry-buttface-7610
#FLUX: -n=9
#FLUX: -t=259200
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$(pwd)/../../../lib/sgpp:$(pwd)/../../../glpk/lib:$LD_LIBRARY_PATH'
export OMP_NUM_THREADS='1'

export LD_LIBRARY_PATH=$(pwd)/../../../lib/sgpp:$(pwd)/../../../glpk/lib:$LD_LIBRARY_PATH
export OMP_NUM_THREADS=1
. ~/spack/share/spack/setup-env.sh
spack load boost@1.74.0
spack load hdf5@1.10.5
mpiexec.openmpi -n $SLURM_NTASKS ./selalib_distributed
