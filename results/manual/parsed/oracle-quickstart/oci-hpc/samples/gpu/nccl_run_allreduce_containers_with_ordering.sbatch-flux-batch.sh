#!/bin/bash
#FLUX: --job-name=nccl-allreduce-slurm-containers
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --urgency=16

export PMI_DEBUG='1'
export SLURM_HOSTFILE='$ORDEREDSRUNMACHINEFILE'
export RX_QUEUE_LEN='8192 \'

export PMI_DEBUG=1
cd /nfs/scratch
mkdir $SLURM_JOB_ID
cd $SLURM_JOB_ID
MACHINEFILE="hostfile"
ORDEREDMACHINEFILE="ordered_hostfile_system_name"
ORDEREDRANKMACHINEFILE="rankfile_system_name"
ORDEREDSRUNMACHINEFILE="ordered_hostfile_system_name_srun"
scontrol show hostnames $SLURM_JOB_NODELIST > $MACHINEFILE
echo MACHINEFILE
cat $MACHINEFILE
source /etc/os-release
if [ $ID == "ol" ] || [ $ID == "centos" ] ; then
    python3 /home/opc/node_ordering_by_rack.py --input_file $MACHINEFILE > /dev/null
elif [ $ID == "debian" ] || [ $ID == "ubuntu" ] ; then
    python3 /home/ubuntu/node_ordering_by_rack.py --input_file $MACHINEFILE > /dev/null
fi
echo ORDEREDMACHINEFILE
cat $ORDEREDMACHINEFILE
echo ORDEREDSRUNMACHINEFILE
cat $ORDEREDSRUNMACHINEFILE
export SLURM_HOSTFILE=$ORDEREDSRUNMACHINEFILE
MPIVARS_PATH=`ls /usr/mpi/gcc/openmpi-*/bin/mpivars.sh`
if [[ "$MPIVARS_PATH" == "" ]]; then
    MPIVARS_PATH=`ls /opt/openmpi-*/bin/mpivars.sh`
fi
if [[ "$MPIVARS_PATH" == "" ]]; then
    echo "Could not find MPIPATH"; exit; fi
source $MPIVARS_PATH
LOCAL_MPI=${MPIVARS_PATH%%/bin*}
shape=`curl -sH "Authorization: Bearer Oracle" -L http://169.254.169.254/opc/v2/instance/ | jq .shape`
if [ $shape == \"BM.GPU.B4.8\" ] || [ $shape == \"BM.GPU.A100-v2.8\" ]
then
  var_UCX_NET_DEVICES=mlx5_0:1
  var_NCCL_IB_HCA="=mlx5_5,mlx5_6,mlx5_7,mlx5_8,mlx5_1,mlx5_2,mlx5_3,mlx5_4,mlx5_14,mlx5_15,mlx5_16,mlx5_17,mlx5_9,mlx5_10,mlx5_11,mlx5_12"
elif [ $shape == \"BM.GPU4.8\" ]
then
  var_UCX_NET_DEVICES=mlx5_4:1
  var_NCCL_IB_HCA="=mlx5_0,mlx5_2,mlx5_6,mlx5_8,mlx5_10,mlx5_12,mlx5_14,mlx5_16,mlx5_1,mlx5_3,mlx5_7,mlx5_9,mlx5_11,mlx5_13,mlx5_15,mlx5_17"
fi
export RX_QUEUE_LEN=8192 \
       IB_RX_QUEUE_LEN=8192 \
       UCX_TLS=ud,self,sm \
       HCOLL_ENABLE_MCAST_ALL=0 \
       coll_hcoll_enable=0 \
       UCX_NET_DEVICES=${var_UCX_NET_DEVICES} \
       NCCL_DEBUG=WARN \
       NCCL_IB_TIMEOUT=16 \
       NCCL_IB_SL=0 \
       NCCL_IB_TC=41 \
       NCCL_IGNORE_CPU_AFFINITY=1 \
       NCCL_IB_GID_INDEX=3 \
       NCCL_ALGO=Ring \
       NCCL_IB_HCA="${var_NCCL_IB_HCA}" \
       OMPI_MCA_coll=^hcoll \
       NCCL_IB_QPS_PER_CONNECTION=4
env | grep "SLURMD_NODENAME="
USER=`whoami`
CONTAINER_IMAGE="/nfs/scratch/nvcr.io+nvidia+pytorch+22.12-py3.sqsh"
CONTAINER_MOUNTS="/home/$USER/nccl-tests:/nccl,$LOCAL_MPI:$LOCAL_MPI"
srun --mpi=pmi2 --gpus-per-node=$SBATCH_GPUS_PER_NODE \
     --ntasks-per-node=$SLURM_NTASKS_PER_NODE \
     --distribution=arbitrary \
     --container-image=$CONTAINER_IMAGE \
     --container-mounts=$CONTAINER_MOUNTS \
     bash -c "
     source $MPIVARS_PATH &&
     /nccl/build/all_reduce_perf -b 1G -e 10G -i$((1024*1024*1024*9)) -n 100
     "
