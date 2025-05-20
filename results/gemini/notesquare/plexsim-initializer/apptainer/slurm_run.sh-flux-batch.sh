#!/bin/bash
#flux: -N 2
#flux: -n 10
#flux: --tasks-per-node=5
#flux: option("walltime", "00:05:00")
#flux: job-name=small_test

# Original Slurm comment: #SBATCH --comment inhouse
# Note: The Slurm partition 'debug1' is not directly translated as Flux handles
# resource allocation differently. If 'debug1' implies specific hardware
# features, a '--requires' option could be added to Flux.

APPTAINER_CONTAINER='apptainer/plexsim_initializer.sif'
PYTHON_ARGS="config_random.yaml test.h5"

MPIRUN_ARGS="--bind-to core --map-by slot:PE=3"
PLEXSIM_N_SUBSETS_PER_NODE=2  # number of gpus per node

# system-specific settings (evergreen,firmworld)
# Note: In a Flux environment, the SLURM_HOME environment variable will not be
# set by the scheduler. Thus, the default value specified here will be used.
# The usability of host Slurm libraries in $SLURM_HOME/lib within the container
# in a Flux environment depends on their presence and compatibility.
SLURM_HOME=${SLURM_HOME:-/shared/lib/slurm-21.08.8}
MPI_HOME=${MPI_HOME:-/shared/lib/ompi-4.1.1}
# ompi_info --all --parsable | grep mca:mca:base:param:mca_param_files:value
OMPI_MCA_PARAM_FILES_PATH=/etc/openmpi

# other common settings
export UCX_POSIX_USE_PROC_LINK=n  # enables RMA in UCX
export APPTAINER_BIND="$MPI_HOME:/opt/ompi,$OMPI_MCA_PARAM_FILES_PATH,$SLURM_HOME/lib:/host_slurm_lib,/usr/lib/:/host_usr_lib"

# debug settings (commented out as in original)
# MPIRUN_ARGS="$MPIRUN_AGRS --report-bindings --display-map --display-allocation" # Note: Original script had typo MPIRUN_AGRS
# export OMPI_MCA_pml_base_verbose=10
# export OMPI_MCA_btl_base_verbose=10
# export OMPI_MCA_pml_ucx_verbose=10
# export OMPI_MCA_pmix_base_verbose=10
# export OMPI_MCA_plm_base_verbose=10

# The mpirun command is kept as is, including -n 1.
# Flux will allocate resources for 10 tasks (2 nodes, 5 tasks/node),
# but this mpirun command will only launch 1 MPI rank using those resources.
# This single rank will be subject to the binding/mapping arguments in MPIRUN_ARGS.
mpirun -n 1 $MPIRUN_ARGS \
    -x MPI4PY_RC_THREAD_LEVEL=serialized \
    $APPTAINER_CONTAINER $PYTHON_ARGS