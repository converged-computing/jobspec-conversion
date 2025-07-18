#!/bin/bash
#FLUX: --job-name=n-5nodes
#FLUX: -N=5
#FLUX: -n=5
#FLUX: -c=24
#FLUX: --queue=a100
#FLUX: -t=1728000
#FLUX: --urgency=16

export MASTER_PORT='$(python - <<EOF'
export NNODES='$SLURM_NNODES'
export NCCL_IB_DISABLE='1'
export OMP_NUM_THREADS='1'
export NCCL_DEBUG='INFO'

set -x -e
echo "start time: $(date)"
echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_JOB_PARTITION"=$SLURM_JOB_PARTITION
echo "SLURM_NNODES"=$SLURM_NNODES
echo "SLURM_GPUS_ON_NODE"=$SLURM_GPUS_ON_NODE
echo "SLURM_SUBMIT_DIR"=$SLURM_SUBMIT_DIR
GPUS_PER_NODE=$SLURM_GPUS_ON_NODE
export MASTER_PORT=$(python - <<EOF
import socket
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(('', 0))
free_port = s.getsockname()[1]
s.close()
print(free_port)
EOF
)
export NNODES=$SLURM_NNODES
WORLD_SIZE=$(($GPUS_PER_NODE*$NNODES)) # M nodes x N GPUs
echo "nnodes: ${NNODES}"
export NCCL_IB_DISABLE=1
export OMP_NUM_THREADS=1
export NCCL_DEBUG=INFO
echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_JOB_PARTITION"=$SLURM_JOB_PARTITION
echo "SLURM_NNODES"=$SLURM_NNODES
echo "SLURM_GPUS_ON_NODE"=$SLURM_GPUS_ON_NODE
echo "SLURM_SUBMIT_DIR"=$SLURM_SUBMIT_DIR
echo SLURM_NTASKS=$SLURM_NTASKS
for (( i=0; i < $SLURM_NTASKS; ++i ))
do
    /opt/slurm/bin/srun -lN1 --mem=200G --gres=gpu:4 -c $SLURM_CPUS_ON_NODE -N 1 -n 1 -r $i bash -c \
    "python train_multi_gpus.py \
        -task_name CellSAM-ViT-B-20GPUs \
        -work_dir ./work_dir \
        -batch_size 8 \
        -num_workers 8 \
        --world_size ${WORLD_SIZE} \
        --bucket_cap_mb 25 \
        --grad_acc_steps 1 \
        --node_rank ${i} \
        --init_method tcp://${MASTER_ADDR}:${MASTER_PORT}" >> ./logs/log_for_${SLURM_JOB_ID}_node_${i}.log 2>&1 &
done
wait
echo "END TIME: $(date)"
