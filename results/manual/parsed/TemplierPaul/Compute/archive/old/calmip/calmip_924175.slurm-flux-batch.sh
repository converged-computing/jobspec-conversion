#!/bin/bash
#FLUX: --job-name=crusty-plant-9070
#FLUX: -N=2
#FLUX: -n=2
#FLUX: -c=36
#FLUX: -t=5184000
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module purge
module load intel/18.2
module load intelmpi/18.2
module load python/3.6.8
source activate /tmpdir/templier/envs/torchenv
cd
wandb enabled
wandb offline
redis_password=$(uuidgen)
export redis_password
nodes=$(scontrol show hostnames "$SLURM_JOB_NODELIST") # Getting the node names
nodes_array=($nodes)
node_1=${nodes_array[0]}
ip=$(srun --nodes=1 --ntasks=1 -w "$node_1" hostname --ip-address) # making redis-address
port=6379
ip_head=$ip:$port
export ip_head
echo "IP Head: $ip_head"
echo "STARTING HEAD at $node_1"
srun --nodes=1 --ntasks=1 -w "$node_1"   ray start --head --node-ip-address="$ip" --port=$port --redis-password="$redis_password" --block &
sleep 30
worker_num=$((SLURM_JOB_NUM_NODES - 1)) #number of nodes other than the head node
for ((i = 1; i <= worker_num; i++)); do
  node_i=${nodes_array[$i]}
  echo "STARTING WORKER $i at $node_i"
  srun --nodes=1 --ntasks=1 -w "$node_i" ray start --address "$ip_head" --redis-password="$redis_password" --block &
  sleep 5
done
echo CMD python3 Rayvolution/simple.py --optim=sepcma --env=Pong-v0 --pop=144
for seed in 0
do 
python3 Rayvolution/simple.py --optim=sepcma --env=Pong-v0 --pop=144
done
