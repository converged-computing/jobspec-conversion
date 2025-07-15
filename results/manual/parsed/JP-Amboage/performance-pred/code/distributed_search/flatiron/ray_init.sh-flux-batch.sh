#!/bin/bash
#FLUX: --job-name=evasive-knife-1370
#FLUX: -c=5
#FLUX: --exclusive
#FLUX: --urgency=16

echo "#################### Job submission script. #############################"
cat $0
echo "################# End of job submission script. #########################"
module load gcc
source ~/venvs/venv1/bin/activate 
python --version
redis_password=$(uuidgen)
export redis_password
echo "Redis password: ${redis_password}"
nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST) # Getting the node names
nodes_array=( $nodes )
node_1=${nodes_array[0]} 
ip=$(srun --nodes=1 --ntasks=1 -w "$node_1" hostname --ip-address) # making redis-address
port=6379
ip_head=$ip:$port
export ip_head
echo "IP Head: $ip_head"
echo "STARTING HEAD at $node_1"
srun --nodes=1 --ntasks=1 -w "$node_1" start-head.sh "$ip" &
sleep 30
worker_num=$(($SLURM_JOB_NUM_NODES - 1)) #number of nodes other than the head node
for ((  i=1; i<=$worker_num; i++ ))
do
  node_i=${nodes_array[$i]}
  echo "STARTING WORKER $i at $node_i"
  srun --nodes=1 --ntasks=1 -w $node_i start-worker.sh $ip_head &
  sleep 5
done
python ray_test.py --cpus "${SLURM_CPUS_PER_TASK}" --gpus "${SLURM_GPUS_PER_TASK}"
exit
