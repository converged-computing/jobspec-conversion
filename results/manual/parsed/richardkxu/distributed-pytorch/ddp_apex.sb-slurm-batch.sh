#!/bin/bash
#SBATCH --job-name=ddl_imagenet
#SBATCH --output=ddl_imagenet.%j.%N.out
#SBATCH --error=ddl_imagenet.%j.%N.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --gres=gpu:v100:4
#SBATCH --mem=1200
#SBATCH --time=1-00:00:00

MASTER=`/bin/hostname -s`
MASTER_IP=`/bin/hostname -i`
SLAVES=`scontrol show hostnames $SLURM_JOB_NODELIST | grep -v $MASTER`
HOSTLIST="$MASTER $SLAVES"
module load wmlce/1.6.2-py3.7
cd /home/kexu6/src/distributed-pytorch
RANK=0
for node in $HOSTLIST; do
  srun -N 1 -n 1 python -m torch.distributed.launch \
    --nproc_per_node=4 \
    --nnodes=$SLURM_JOB_NUM_NODES \
    --node_rank=$RANK \
    --master_addr=$MASTER_IP --master_port=8888 \
    imagenet_ddp_apex.py -a resnet50 -b 208 --workers 20 \
    --opt-level O2 /home/shared/imagenet/raw/ &
  RANK=$((RANK+1))
done
wait
