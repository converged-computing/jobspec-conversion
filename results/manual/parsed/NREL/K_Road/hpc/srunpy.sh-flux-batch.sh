#!/bin/bash
#FLUX: --job-name=srunpy
#FLUX: -N=6
#FLUX: -c=36
#FLUX: -t=900
#FLUX: --priority=16

source ~/acavs
unset LD_PRELOAD
memory_per_node=$((36*1024*1024*1024))
object_store_memory=$((18*1024*1024*1024))
driver_object_store_memory=$((18*1024*1024*1024))
code
worker_num=$(($SLURM_JOB_NUM_NODES - 1))
total_cpus=$(($SLURM_JOB_NUM_NODES * $SLURM_CPUS_ON_NODE))
echo "worker_num="$worker_num
echo "total_cpus="$total_cpus
nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST) # Getting the node names
nodes_array=($nodes)
echo "nodes: "$nodes
echo "nodes_array: "$nodes_array
node1=${nodes_array[0]}
echo "node1: "$node1
ip_prefix=$(srun --nodes=1 --ntasks=1 -w $node1 hostname --ip-address) # Making address
suffix=':6379'
ip_head=$ip_prefix$suffix
redis_password=$(uuidgen)
echo "ip_prefix: "$ip_pref
echo "suffix: "$suffix
echo "ip_head: "$ip_head
echo "redis_password: "$redis_password
export ip_head # Exporting for latter access
echo "starting head"
srun --nodes=1 --ntasks=1 -w $node1 ray start --block --head --port=6379 --redis-password=$redis_password --memory=$memory_per_node --object-store-memory=$object_store_memory --num-cpus=36 &# Starting the head
sleep 60
echo "starting workers"
for ((i = 1; i <= $worker_num; i++)); do
  node2=${nodes_array[$i]}
  echo "i=${i}, node2=${node2}"
  srun --nodes=1 --ntasks=1 -w $node2 ray start --block --address=$ip_head --redis-password=$redis_password  --memory=$memory_per_node --object-store-memory=$object_store_memory --num-cpus=36 &# Starting the workers
  sleep 5
done
echo "executing command... python -u "$@" ray " "$redis_password" "$total_cpus"
python -u "$@" ray "$redis_password" "$total_cpus"
