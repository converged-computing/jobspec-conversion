#!/bin/bash
#FLUX: --job-name=pusheena-lemur-1027
#FLUX: -c=40
#FLUX: -t=36000
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export NCCL_SOCKET_IFNAME='ib0'
export PYTHONFAULTHANDLER='1'
export DATA_DIR='/ibex/ai/reference/CV/ILSVR/classification-localization/data/jpeg'
export OMP_NUM_THREADS='1'

scontrol show job $SLURM_JOBID 
source /ibex/ai/home/$USER/miniconda3/bin/activate dist-pytorch
export NCCL_DEBUG=INFO
export NCCL_SOCKET_IFNAME=ib0
export PYTHONFAULTHANDLER=1
export DATA_DIR=/ibex/ai/reference/CV/ILSVR/classification-localization/data/jpeg
nodes=$(scontrol show hostnames "$SLURM_JOB_NODELIST")
nodes_array=($nodes)
echo "Node IDs of participating nodes ${nodes_array[*]}"
head_node="${nodes_array[0]}"
echo "Getting the IP address of the head node ${head_node}"
master_ip=$(srun -n 1 -N 1 --gpus=1 -w ${head_node} /bin/hostname -I | cut -d " " -f 2)
master_port=10121
echo "head node is ${master_ip}:${master_port}"
export OMP_NUM_THREADS=1
for (( i=0; i< ${SLURM_NNODES}; i++ ))
do
     srun -n 1 -N 1 -c ${SLURM_CPUS_PER_TASK} -w ${nodes_array[i]} --gpus=${SLURM_GPUS_PER_NODE}  \
      python -m torch.distributed.launch --use_env \
     --nproc_per_node=${SLURM_GPUS_PER_NODE} --nnodes=${SLURM_NNODES} --node_rank=${i} \
     --master_addr=${master_ip} --master_port=${master_port} \
     multi_GPU.py --epochs=10 --lr=0.001 --num-workers=10 &
done
wait
