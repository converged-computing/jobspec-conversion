#!/bin/bash
#FLUX: --job-name=phat-eagle-9982
#FLUX: -t=1200
#FLUX: --priority=16

export NCCL_TOPO_FILE='/nccl/p4d-24xl-topo.xml'

export NCCL_TOPO_FILE=/nccl/p4d-24xl-topo.xml
env | grep "SLURMD_NODENAME="
env | grep "SLURM_NODELIST="
srun --mpi=pmix --container-image=../../nemo_megatron_training.sqsh \
     --container-mounts="$PWD:/nccl" \
     bash -c "
     /nccl/nccl-tests/build/all_reduce_perf -b 256M -e 8G -f 2 -c 1 -n 10"
