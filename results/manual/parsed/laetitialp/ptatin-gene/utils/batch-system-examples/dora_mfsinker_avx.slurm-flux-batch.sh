#!/bin/bash
#FLUX: --job-name="pTat3d"
#FLUX: -n=64
#FLUX: -t=600
#FLUX: --priority=16

EXEC=${PWD}/${PETSC_ARCH}/bin/ptatin_driver_linear_ts.app
aprun -n $SLURM_NTASKS -N $SLURM_NTASKS_PER_NODE $EXEC -options_file src/models/viscous_sinker/examples/sinker-mfscaling.opts -a11_op avx
exit
