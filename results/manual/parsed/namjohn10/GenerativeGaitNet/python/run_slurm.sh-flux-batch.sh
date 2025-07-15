#!/bin/bash
#FLUX: --job-name=test
#FLUX: -N=4
#FLUX: -c=128
#FLUX: --queue=all
#FLUX: --priority=16

module load cuda/cuda-11.0
source ~/venv/bin/activate
let "worker_num=(${SLURM_NTASKS} - 1)"
let "total_cores=${SLURM_NTASKS} * ${SLURM_CPUS_PER_TASK}"
suffix='6379'
ip_head=$1:$suffix
export ip_head # Exporting for latter access by trainer.py
ulimit -n 65536
srun --nodes=1 --ntasks=1 --cpus-per-task=${SLURM_CPUS_PER_TASK} --nodelist=$1 --export=ALL,NCCL_SOCKET_IFNAME=ib0 ray start --head --block --dashboard-host 0.0.0.0 --port=6379 --num-cpus ${SLURM_CPUS_PER_TASK} &
sleep 5
srun --nodes=${worker_num} --ntasks=${worker_num} --cpus-per-task=${SLURM_CPUS_PER_TASK} --exclude=$1 --export=ALL,NCCL_SOCKET_IFNAME=ib0 ray start --address $ip_head --block --num-cpus ${SLURM_CPUS_PER_TASK} &
sleep 5
python3 -u ray_train.py -m --config=$2 --name=$3 $4 --cluster 
