#!/bin/bash
#FLUX: --job-name=loopy-toaster-9548
#FLUX: -N=2
#FLUX: --queue=debug
#FLUX: -t=3540
#FLUX: --urgency=16

export EXAWIND_DIR='/nopt/nrel/ecom/exawind/exawind-2020-09-21/install/gcc'
export MPI_TYPE_DEPTH='15'
export MPI_IB_CONGESTED='true'
export MPI_XPMEM_ENABLED='disabled'

module purge
module load gcc/8.4.0 mpt mkl cmake
export EXAWIND_DIR=/nopt/nrel/ecom/exawind/exawind-2020-09-21/install/gcc
export MPI_TYPE_DEPTH=15
export MPI_IB_CONGESTED=true
export MPI_XPMEM_ENABLED=disabled
cd /scratch/orybchuk/wakedynamics/amr-wind-tutorial/02_atmosphere/spinup
rm -rf post_processing
ln -sf /projects/awaken/orybchuk/spack-june22/amr-wind/spack-build-4ixvlaf/amr_wind .
srun -n 72 -c 1 --cpu_bind=cores amr_wind spinup.i
