#!/bin/bash
#FLUX: --job-name=loopy-fudge-4910
#FLUX: --priority=16

export NUM_GPUS='$( echo $CUDA_VISIBLE_DEVICES | awk -F ',' '{print NF}' )'

config=$1
source activate molpal
export NUM_GPUS=$( echo $CUDA_VISIBLE_DEVICES | awk -F ',' '{print NF}' )
redis_password=$( uuidgen 2> /dev/null )
export redis_password
nodes=$( scontrol show hostnames $SLURM_JOB_NODELIST ) # Getting the node names
nodes_array=( $nodes )
node_0=${nodes_array[0]} 
ip=$( srun -N 1 -n 1 -w $node_0 hostname --ip-address ) # making redis-address
port=$( python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()' )
ip_head=$ip:$port
export ip_head
echo "IP Head: $ip_head"
srun -N 1 -n 1 -w $node_0 ray start --head \
    --node-ip-address=$ip --port=$port --redis-password=$redis_password \
    --num-cpus $SLURM_CPUS_ON_NODE --num-gpus $NUM_GPUS \
    --temp-dir /tmp/degraff --block > /dev/null 2>& 1 &
sleep 30
worker_num=$(( $SLURM_JOB_NUM_NODES - 1 ))
for ((  i=1; i<=$worker_num; i++ )); do
    node_i=${nodes_array[$i]}
    echo "STARTING WORKER $i at $node_i"
    srun -N 1 -n 1 -w $node_i ray start --address $ip_head \
        --redis-password=$redis_password \
        --num-cpus $SLURM_CPUS_ON_NODE --num-gpus $NUM_GPUS \
        --temp-dir /tmp/degraff --block > /dev/null 2>& 1 &
    sleep 5
done
python run.py --config $config --ncpu $SLURM_CPUS_PER_TASK
