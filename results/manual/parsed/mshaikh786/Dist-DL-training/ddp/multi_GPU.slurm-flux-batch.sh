#!/bin/bash
#FLUX: --job-name=boopy-chair-7838
#FLUX: -c=4
#FLUX: -t=600
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'
export DATA_DIR='/ibex/ai/reference/CV/tinyimagenet'
export OMP_NUM_THREADS='1'

scontrol show job $SLURM_JOBID 
module load dl
module load pytorch
module list
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
export DATA_DIR=/ibex/ai/reference/CV/tinyimagenet
nodes=$(scontrol show hostnames "$SLURM_JOB_NODELIST")
nodes_array=($nodes)
echo "Node IDs of participating nodes ${nodes_array[*]}"
head_node="${nodes_array[0]}"
echo "Getting the IP address of the head node ${head_node}"
master_ip=$(srun -n 1 -N 1 --gpus=1 -w ${head_node} /bin/hostname -I | cut -d " " -f 2)
master_port=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
echo "head node is ${master_ip}:${master_port}"
sleep 5
echo -e " 
To connect to the NVIDIA Dashboard and monitor your GPU utilzation do the following:
Copy the following command and paste in new terminal:
ssh -L localhost:${nv_board}:${HOSTNAME}.ibex.kaust.edu.sa:${nv_board} ${USER}@glogin.ibex.kaust.edu.sa 
"
export OMP_NUM_THREADS=1
for (( i=0; i< ${SLURM_NNODES}; i++ ))
do
     srun -n 1 -N 1 -c ${SLURM_CPUS_PER_TASK} -w ${nodes_array[i]} --gpus=${SLURM_GPUS_PER_NODE}  \
      python -m torch.distributed.launch --use_env \
     --nproc_per_node=${SLURM_GPUS_PER_NODE} --nnodes=${SLURM_NNODES} --node_rank=${i} \
     --master_addr=${master_ip} --master_port=${master_port} \
     ddp.py --epochs=5 --lr=0.001 --num-workers=${SLURM_CPUS_PER_TASK} --batch-size=64 &
done
wait
