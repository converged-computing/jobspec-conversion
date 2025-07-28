#!/bin/bash
#FLUX: --job-name=out_heat
#FLUX: -n=4
#FLUX: --queue=cpu_short
#FLUX: -t=30
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK} '
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

module purge
module load gcc/11.2.0/gcc-4.8.5 hdf5/1.10.7/gcc-11.2.0-openmpi openmpi/4.1.1/gcc-11.2.0 cmake/3.21.4/gcc-11.2.0
. path_to_pdi_install/share/pdi/env.bash
set -x
cd ${SLURM_SUBMIT_DIR}
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK} 
export OMP_PLACES=cores
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
pdirun srun ./my_app
