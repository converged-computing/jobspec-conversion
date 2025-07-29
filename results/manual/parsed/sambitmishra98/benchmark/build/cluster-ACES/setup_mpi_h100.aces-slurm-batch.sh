#!/bin/bash
#FLUX: --job-name=mpi-build
#FLUX: -n=16
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=21600
#FLUX: --urgency=16

/sw/local/bin/query_gpu.sh
nvidia-smi -L ; clinfo -l
source ~/.bashrc
echo -e "\n================================================================="
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
LATEST_BUILD_H100
ml CUDA/$BUILD_EASY_CUDA_VER
add_installation_to_path gcc      $BUILD_GCC_VER     $PKG_LOCAL
CMD="${BUILD_PATH}/build_scripts/build_mpi.script"
echo -e "\n$CMD\n"
eval $CMD
add_installation_to_path final-compute-amd/ucx     $BUILD_UCX_VER     $PKG_LOCAL
add_installation_to_path final-compute-amd/openmpi $BUILD_OPENMPI_VER $PKG_LOCAL
add_installation_to_path ${BUILD_NAME_MPI}-${BUILD_TAG_MPI}/ucx     ${BUILD_UCX_VER}     ${PKG_LOCAL}
add_installation_to_path ${BUILD_NAME_MPI}-${BUILD_TAG_MPI}/openmpi ${BUILD_OPENMPI_VER} ${PKG_LOCAL}
