#!/bin/bash
#FLUX: --job-name=starccm
#FLUX: --exclusive
#FLUX: --urgency=16

export FI_EFA_FORK_SAFE='1'
export I_MPI_OFI_LIBRARY_INTERNAL='0'
export I_MPI_FABRICS='shm:ofi'
export I_MPI_OFI_PROVIDER='efa'
export I_MPI_DEBUG='10'
export I_MPI_HYDRA_BOOTSTRAP='slurm'

module load intelmpi
export FI_EFA_FORK_SAFE=1
export I_MPI_OFI_LIBRARY_INTERNAL=0
module load libfabric-aws
export I_MPI_FABRICS=shm:ofi
export I_MPI_OFI_PROVIDER=efa
export I_MPI_DEBUG=10
export FI_EFA_FORK_SAFE=1
export I_MPI_HYDRA_BOOTSTRAP="slurm"
SHARED_DIR="/shared"
TARGET_USER=$(whoami)
STARCCM="${SHARED_DIR}/${TARGET_USER}/STAR-CCM+/16.02.008/STAR-CCM+16.02.008/star/bin/starccm+"
SIM_FILE="${SHARED_DIR}/${TARGET_USER}/lemans_poly_17m.amg@00500.sim"
podkey="$1"
licpath="$2"
${STARCCM} \
        -bs slurm \
        -power \
        -batch \
        -podkey "${podkey}" \
        -licpath "${licpath}" \
        -mpi intel \
        -xsystemlibfabric -ldlibpath /opt/amazon/efa/lib64 \
        -fabric OFI -vvv \
        ${SIM_FILE}
