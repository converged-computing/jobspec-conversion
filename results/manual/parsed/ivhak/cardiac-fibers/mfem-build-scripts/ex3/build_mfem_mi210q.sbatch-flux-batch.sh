#!/bin/bash
#FLUX: --job-name=build-mfem-mi210q
#FLUX: -n=4
#FLUX: --queue=mi210q
#FLUX: -t=10800
#FLUX: --urgency=16

MFEM_BUILD_DIR=./build-mi210q
MFEM_INSTALL_DIR=/global/D1/homes/iverh/packages/mi210q/mfem-4.5
set -e
module purge
module use /global/D1/homes/james/ex3modules/mi210q/20221215/modulefiles
module load amd/rocm/5.1.3
module load hypre-32-2.25.0-gfx90a
module load openmpi-4.1.4
module load metis-32-5.1.0
make BUILD_DIR=${MFEM_BUILD_DIR} config \
    MFEM_USE_MPI=YES \
    MPICXX=mpic++ \
    MFEM_USE_HIP=YES \
    MFEM_USE_METIS=YES \
    MFEM_USE_METIS_5=YES \
    HYPRE_LIB="-L${HYPRE_LIBDIR} -lHYPRE" \
    HYPRE_OPT="-I${HYPRE_INCDIR}" \
    METIS_LIB="-L${METIS_LIBDIR} -lmetis" \
    METIS_OPT="-I${METIS_INCDIR}" \
    HIP_ARCH=gfx90a
make BUILD_DIR=${MFEM_BUILD_DIR} -j 4
make BUILD_DIR=${MFEM_BUILD_DIR} check
make BUILD_DIR=${MFEM_BUILD_DIR} install PREFIX=${MFEM_INSTALL_DIR}
