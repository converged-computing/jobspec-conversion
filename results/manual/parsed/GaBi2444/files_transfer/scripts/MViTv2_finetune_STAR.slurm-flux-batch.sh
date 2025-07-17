#!/bin/bash
#FLUX: --job-name=MViTv2_finetune_STAR
#FLUX: -N=4
#FLUX: -c=10
#FLUX: --exclusive
#FLUX: -t=86400
#FLUX: --urgency=16

export HOROVOD_GPU_ALLREDUCE='MPI'
export HOROVOD_GPU_ALLGATHER='MPI'
export HOROVOD_GPU_BROADCAST='MPI'
export NCCL_DEBUG='DEBUG'

HOME2=/nobackup/users/$(whoami)
PYTHON_VIRTUAL_ENVIRONMENT=slowfast
CONDA_ROOT=$HOME2/anaconda3
source ${CONDA_ROOT}/etc/profile.d/conda.sh
conda activate $PYTHON_VIRTUAL_ENVIRONMENT
ulimit -s unlimited
echo " "
echo "Job name" $SLURM_JOB_NAME
echo " Nodelist:= " $SLURM_JOB_NODELIST
echo " Number of nodes:= " $SLURM_JOB_NUM_NODES
echo " GPUs per node:= " $SLURM_JOB_GPUS
echo " Ntasks per node:= "  $SLURM_NTASKS_PER_NODE
export HOROVOD_GPU_ALLREDUCE=MPI
export HOROVOD_GPU_ALLGATHER=MPI
export HOROVOD_GPU_BROADCAST=MPI
export NCCL_DEBUG=DEBUG
echo " Running on multiple nodes/GPU devices"
echo ""
echo " Run started at:- "
date
MASTER=`/bin/hostname -s`
SLAVES=`scontrol show hostnames $SLURM_JOB_NODELIST | grep -v $MASTER`
HOSTLIST="$MASTER $SLAVES"
MPORT=4002
RANK=0
PWD=`pwd`
DATA_ROOT="/nobackup/"
CMD="cd $PWD && python ../code/slowfast/tools/run_net.py --cfg ../code/slowfast/configs/STAR/MVITv2_B_32x3.yaml --opts NUM_SHARDS ${SLURM_JOB_NUM_NODES} NUM_GPUS 4 OUTPUT_DIR ./"${SLURM_JOB_NAME}$"/ "
CMD=${CMD}"TRAIN.CHECKPOINT_EPOCH_RESET True TRAIN.CHECKPOINT_FILE_PATH ../exp/MViTv2_finetune_K400/checkpoints/checkpoint_epoch_00060.pyth MODEL.NUM_CLASSES 111 "
CMD=${CMD}"DATA.PATH_TO_DATA_DIR "${DATA_ROOT}"users/bowu/data/STAR/Situation_Video_Data/ DATA.PATH_PREFIX "${DATA_ROOT}"projects/public/charades/Charades_v1_rgb/ "
echo "Basic commend:"$CMD
echo "master node is $MASTER, master port is $MPORT, slave nodes are $SLAVES"
for node in $HOSTLIST; do
        node_cmd=${CMD}" SHARD_ID $RANK"
        echo $node_cmd
        ssh -q $node $node_cmd &
        if [ $RANK == 0 ]; then
             count=0
             #while ! nc -zvw3 $MASTER $MPORT >/dev/null 2>&1; do
             #     sleep 5
             #     count=$((count+1))
             #     if [ $count == 360 ];then
             #          echo "wait 30 min for master start... exit..."
             #     fi
             #done
        fi
        RANK=$((SLURM_NTASKS_PER_NODE+RANK))
done
wait
echo "Run completed at:- "
date
