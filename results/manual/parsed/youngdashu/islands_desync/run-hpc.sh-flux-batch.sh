#!/bin/bash
#FLUX: --job-name=my-workload
#FLUX: -N=5
#FLUX: -n=120
#FLUX: --queue=plgrid
#FLUX: --urgency=16

export TMPDIR='$tmpdir'
export RAY_TMPDIR='$tmpdir'
export PYTHONPATH='${PYTHONPATH}:$PWD'

module load python/3.10.4-gcccore-11.3.0
source ~/rayenv/bin/activate
set -x
mkdir "/tmp/$USER/$SLURM_JOB_ID"
tmpdir="/tmp/$USER/$SLURM_JOB_ID"
export TMPDIR=$tmpdir
export RAY_TMPDIR=$tmpdir
export PYTHONPATH="${PYTHONPATH}:$PWD"
nodes=$(scontrol show hostnames "$SLURM_JOB_NODELIST")
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)
port=6379
ip_head=$head_node_ip:$port
export ip_head
echo "IP Head: $ip_head"
echo "Starting HEAD at $head_node"
srun --nodes=1 --ntasks=1 -w "$head_node" \
    ray start --head --node-ip-address="$head_node_ip" --port=$port --temp-dir="$tmpdir" --block &
worker_num=$((SLURM_JOB_NUM_NODES - 1))
for ((i = 1; i <= worker_num; i++)); do
    node_i=${nodes_array[$i]}
    echo "Starting WORKER $i at $node_i"
    srun --nodes=1 --ntasks=1 -w "$node_i" --export=ALL,RAY_TMPDIR="$tmpdir" \
        ray start --address "$ip_head" --block &
    sleep 1
done
number_of_migrants=5
migration_interval=5
dda=$(date +%y%m%d)
tta=$(date +g%H%M%S)
python3 -u islands_desync/start.py 100 $tmpdir $number_of_migrants $migration_interval $dda $tta
