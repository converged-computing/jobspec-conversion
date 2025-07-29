#!/bin/bash
#SBATCH --account=<YOUR-PROJECT-CODE>
#SBATCH --nodes=3
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:03:00
#SBATCH --constraint=ntasks-per-node=1

source activate flower-slurm
ip=$(hostname --ip-address)
nodes=$(scontrol show hostnames "$SLURM_JOB_NODELIST") # Getting the node names
nodes_array=($nodes)
locations=("A" "B")
worker_num=$((SLURM_JOB_NUM_NODES - 1)) # number of nodes other than the server node
for ((i = 1; i <= worker_num; i++)); do
  node_i=${nodes_array[$i]}
  echo "Starting Client $i at $node_i"
  # launch clients but delay call to python client (so there is time for the server to start up)
  srun --nodes=1 --ntasks=1 -w "$node_i" python client.py server.address=$ip wait_for_server=15 location=${locations[$i-1]} &
done
echo "Starting server at $ip"
python server.py address=$ip
