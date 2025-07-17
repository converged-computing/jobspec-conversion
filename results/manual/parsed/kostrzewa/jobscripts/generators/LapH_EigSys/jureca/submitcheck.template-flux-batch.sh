#!/bin/bash
#FLUX: --job-name=outstanding-lemur-7282
#FLUX: -N=4
#FLUX: -c=4
#FLUX: -t=3540
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'
export LD_LIBRARY_PATH='${LD_LIBRARY_PATH}:/homec/hbn28/hbn282/code/petsc/arch-linux2-c-opt/lib/:/homec/hbn28/hbn282/code/slepc/arch-linux2-c-opt/lib/'

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/homec/hbn28/hbn282/code/petsc/arch-linux2-c-opt/lib/:/homec/hbn28/hbn282/code/slepc/arch-linux2-c-opt/lib/
module r
date
srun --exclusive -n ${SLURM_NTASKS} --cpu_bind=sockets ./ev_largest -log_summary =L=
date
