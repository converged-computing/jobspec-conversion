#!/bin/bash
#FLUX: --job-name=bloated-carrot-5558
#FLUX: -N=2
#FLUX: --queue=p40
#FLUX: --urgency=16

cd /raid/slurm-for-quantum/home/qc01/cyc/TeD-Q/tedq/distributed_worker/
rank=$(($SLURM_PROCID+1))
srun python rpc_workers.py --num_nodes 2 --rank $rank --gpus_per_cpu 4 --cpus_per_node 1 --master_addr 172.17.224.177
