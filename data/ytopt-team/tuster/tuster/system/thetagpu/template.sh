#!/bin/sh
#COBALT -A {{ A }}
#COBALT -n {{ n }}
#COBALT -q {{ q }}
#COBALT -t {{ t }}

source {{ env }}

# USER CONFIGURATION
CPUS_PER_TASK={{ cpu_per_task }}
GPUS_PER_TASK={{ gpu_per_task }}

# Script to launch Ray cluster

ACTIVATE_PYTHON_ENV={{ env }}
echo "Script to activate Python env: $ACTIVATE_PYTHON_ENV"


# Getting the node names
mapfile -t nodes_array -d '\n' < $COBALT_NODEFILE

head_node=${nodes_array[0]}
head_node_ip=$(dig $head_node a +short | awk 'FNR==2')

# if we detect a space character in the head node IP, we'll
# convert it to an ipv4 address. This step is optional.
if [[ "$head_node_ip" == *" "* ]]; then
IFS=' ' read -ra ADDR <<<"$head_node_ip"
if [[ ${#ADDR[0]} -gt 16 ]]; then
  head_node_ip=${ADDR[1]}
else
  head_node_ip=${ADDR[0]}
fi
echo "IPV6 address detected. We split the IPV4 address as $head_node_ip"
fi

# Starting the Ray Head Node
port=6379
ip_head=$head_node_ip:$port
export ip_head
echo "IP Head: $ip_head"

echo "Starting HEAD at $head_node"
ssh -tt $head_node_ip "source $ACTIVATE_PYTHON_ENV; \
    ray start --head --node-ip-address=$head_node_ip --port=$port \
    --num-cpus $CPUS_PER_TASK --num-gpus $GPUS_PER_TASK --block" &

# optional, though may be useful in certain versions of Ray < 1.0.
sleep 10

# number of nodes other than the head node
worker_num=$((${#nodes_array[*]} - 1))
echo "$worker_num workers"

for ((i = 1; i <= worker_num; i++)); do
    node_i=${nodes_array[$i]}
    node_i_ip=$(dig $node_i a +short | awk 'FNR==1')
    echo "Starting WORKER $i at $node_i with ip=$node_i_ip"
    ssh -tt $node_i_ip "source $ACTIVATE_PYTHON_ENV; \
        ray start --address $ip_head \
        --num-cpus $CPUS_PER_TASK --num-gpus $GPUS_PER_TASK" --block &
    sleep 5
done

# Execute program
{{ exe }}

