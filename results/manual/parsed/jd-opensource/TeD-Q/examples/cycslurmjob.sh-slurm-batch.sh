#!/bin/bash
#SBATCH --job-name=myFirstJob
#SBATCH --output=job.%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --constraint=ntasks-per-node=1

cd /raid/slurm-for-quantum/home/qc01/cyc/TeD-Q/tedq/distributed_worker/
rank=$(($SLURM_PROCID+1))
srun python rpc_workers.py --num_nodes 2 --rank $rank --gpus_per_cpu 4 --cpus_per_node 1 --master_addr 172.17.224.177
