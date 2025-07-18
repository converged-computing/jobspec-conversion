#!/bin/bash
#FLUX: --job-name=pyfr-script
#FLUX: -N=3
#FLUX: -n=9
#FLUX: --exclusive
#FLUX: --queue=amd
#FLUX: -t=21600
#FLUX: --urgency=16

    . /etc/profile.d/modules.sh
    module purge
    rocm-smi
    # nvidia-smi -L ; clinfo -l
    source ~/.bashrc
    echo -e "\n================================================================="
    export BUILD_NAME="pvc"
    export BUILD_TAG="aces"
    export BUILD_NAME_PYTHON="pvc"
    export BUILD_TAG_PYTHON="aces"
    export BUILD_NAME_OMPI="pvc"
    export BUILD_TAG_OMPI="aces"
    numnodes=$SLURM_JOB_NUM_NODES
    mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
    np=$[${SLURM_JOB_NUM_NODES}*${mpi_tasks_per_node}]
    echo "Running on master node: `hostname`"
    echo "Time: `date`"
    echo "Current directory: `pwd`"
    echo -e "JobID: $SLURM_JOB_ID\n================================================================="
    echo -e "Tasks=${SLURM_NTASKS},\
            nodes=${SLURM_JOB_NUM_NODES}, \
            mpi_tasks_per_node=${mpi_tasks_per_node} \
            (OMP_NUM_THREADS=$OMP_NUM_THREADS)"
    setup_base
    export_all_versions
    add_installation_to_path rocm-6.0.0 ""                 "/opt"
    add_installation_to_path gcc      $BUILD_GCC_VER     $PKG_LOCAL
    add_installation_to_path ${BUILD_NAME_PYTHON}-${BUILD_TAG_PYTHON}/libffi  $BUILD_LIBFFI_VER  $PKG_LOCAL
    add_installation_to_path ${BUILD_NAME_PYTHON}-${BUILD_TAG_PYTHON}/openssl $BUILD_OPENSSL_VER $PKG_LOCAL
    add_installation_to_path ${BUILD_NAME_PYTHON}-${BUILD_TAG_PYTHON}/python  $BUILD_PYTHON_VER  $PKG_LOCAL
    add_installation_to_path ${BUILD_NAME_OMPI}-${BUILD_TAG_OMPI}/mpich     $BUILD_MPICH_VER $PKG_LOCAL
    add_optional_pyfr_dependencies
    source $VENV_LOCAL/venv-${BUILD_NAME}-${BUILD_TAG}/bin/activate
    CMD="${BUILD_PATH}/pyfr.build ${BUILD_NAME} ${BUILD_TAG} ${np}"
    echo -e "\n$CMD\n"
    eval $CMD
echo -e "\n--------------------------------------------------\n"
echo -e "\n MPI test begins\n"
CMD="mpirun -n ${np} python3 -c 'from mpi4py import MPI; print(MPI.COMM_WORLD.Get_rank())'"
echo -e "\n$CMD\n"
eval $CMD
echo -e "\n MPI test complete\n"
echo -e "\n--------------------------------------------------\n"
echo -e "\nSimulation ends\n"
