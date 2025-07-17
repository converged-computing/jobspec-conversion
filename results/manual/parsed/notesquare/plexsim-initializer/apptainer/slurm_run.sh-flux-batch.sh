#!/bin/bash
#FLUX: --job-name=small_test
#FLUX: -N=2
#FLUX: --queue=debug1
#FLUX: -t=300
#FLUX: --urgency=16

export UCX_POSIX_USE_PROC_LINK='n  # enables RMA in UCX'
export APPTAINER_BIND='$MPI_HOME:/opt/ompi,$OMPI_MCA_PARAM_FILES_PATH,$SLURM_HOME/lib:/host_slurm_lib,/usr/lib/:/host_usr_lib'

APPTAINER_CONTAINER='apptainer/plexsim_initializer.sif'
PYTHON_ARGS="config_random.yaml test.h5"
MPIRUN_ARGS="--bind-to core --map-by slot:PE=3"
PLEXSIM_N_SUBSETS_PER_NODE=2  # number of gpus per node
SLURM_HOME=${SLURM_HOME:-/shared/lib/slurm-21.08.8}
MPI_HOME=${MPI_HOME:-/shared/lib/ompi-4.1.1}
OMPI_MCA_PARAM_FILES_PATH=/etc/openmpi
export UCX_POSIX_USE_PROC_LINK=n  # enables RMA in UCX
export APPTAINER_BIND="$MPI_HOME:/opt/ompi,$OMPI_MCA_PARAM_FILES_PATH,$SLURM_HOME/lib:/host_slurm_lib,/usr/lib/:/host_usr_lib"
mpirun -n 1 $MPIRUN_ARGS \
    -x MPI4PY_RC_THREAD_LEVEL=serialized \
    $APPTAINER_CONTAINER $PYTHON_ARGS
