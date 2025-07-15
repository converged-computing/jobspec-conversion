#!/bin/bash
#FLUX: --job-name="forl-proj"
#FLUX: -n=2
#FLUX: -c=6
#FLUX: -t=82800
#FLUX: --priority=16

module load gcc/8.2.0 python_gpu/3.10.4 cuda/11.8.0 git-lfs/2.3.0 git/2.31.1 eth_proxy cudnn/8.8.1.3
source "${SCRATCH}/.python_venv/forl-proj/bin/activate"
ray_temp_dir="${SCRATCH}/.tmp_ray"
if [ ! -d ${ray_temp_dir} ]; then
    mkdir ${ray_temp_dir}
fi
redis_password=$(uuidgen)
export redis_password
nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST) # Getting the node names
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)
if [[ "$head_node_ip" == *" "* ]]; then
    IFS=' ' read -ra ADDR <<<"$head_node_ip"
    if [[ ${#ADDR[0]} -gt 16 ]]; then
        head_node_ip=${ADDR[1]}
    else
        head_node_ip=${ADDR[0]}
    fi
    echo "IPV6 address detected. We split the IPV4 address as $head_node_ip"
fi
port=$((6379 + $RANDOM % 100))
ip_head=$head_node_ip:$port
export ip_head
echo "IP Head: $ip_head"
echo "STARTING HEAD at $head_node"
srun --nodes=1 --ntasks=1 -w $head_node \
    ray start --head --node-ip-address=$head_node_ip --port=$port \
    --redis-password=$redis_password \
    --block --disable-usage-stats &
sleep 30
worker_num=$(($SLURM_JOB_NUM_NODES - 1)) # number of nodes other than the head node
for ((i = 1; i <= $worker_num; i++)); do
    node_i=${nodes_array[$i]}
    echo "STARTING WORKER $i at $node_i"
    srun --nodes=1 --ntasks=1 -w $node_i \
        ray start --address $ip_head \
        --redis-password=$redis_password \
        --block --disable-usage-stats &
    sleep 5
done
sleep 30
ray status
echo "STARTING MAIN PROGRAM"
