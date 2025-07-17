#!/bin/bash
#FLUX: --job-name=purple-sundae-6614
#FLUX: -N=4
#FLUX: -c=28
#FLUX: --exclusive
#FLUX: --queue=compute
#FLUX: -t=604800
#FLUX: --urgency=16

. scripts/env.sh
. $CONDA_DIR/bin/activate
conda activate $CONDA_ENV
nodes=$(scontrol show hostnames "$SLURM_JOB_NODELIST")
nodes_array=($nodes)
head_node=${nodes_array[0]}
ip_prefix=$(srun --nodes=1 --ntasks=1 -w $head_node hostname --ip-address)
ip_head=$ip_prefix:$PORT
echo "head node is at $ip_head"
if [[ "$ip_prefix" == *" "* ]]; then
IFS=' ' read -ra ADDR <<<"$ip_prefix"
if [[ ${#ADDR[0]} -gt 16 ]]; then
  ip_prefix=${ADDR[1]}
else
  ip_prefix=${ADDR[0]}
fi
echo "IPV6 address detected. We split the IPV4 address as $ip_prefix"
fi
srun --nodes=1 --ntasks=1 -w $head_node ray start --num-cpus "${SLURM_CPUS_PER_TASK}" --head \
--node-ip-address="$ip_prefix" --port=$PORT --redis-password=$REDIS_PWD --block & 
sleep 10
echo "starting workers"
for ((  i=1; i<=$WORKER_NUM; i++ ))
do
    node2=${nodes_array[$i]}
    echo "i=${i}, w = ${w}, node2=$node2"
    srun --nodes=1 --ntasks=1 -w $node2 ray start --num-cpus "${SLURM_CPUS_PER_TASK}" --address "$ip_head" --redis-password=$REDIS_PWD --block &
    sleep 5
done
python train_ppo.py --num-workers $(( $WORKER_PER_NODE * ( $WORKER_NUM + 1 )))
