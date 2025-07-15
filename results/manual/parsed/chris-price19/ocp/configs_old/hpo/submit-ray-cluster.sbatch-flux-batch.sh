#!/bin/bash
#FLUX: --job-name=h1c2
#FLUX: -c=32
#FLUX: --gpus-per-task=8
#FLUX: --queue=g_vsheno
#FLUX: -t=525600
#FLUX: --urgency=16

module purge
module load gcc-9.2.0/9.2.0
module load gpu/cuda/10.2
ulimit -s unlimited
ulimit -n 4096
eval "$(conda shell.bash hook)"
source activate ocp-gpu
ray stop
redis_password=$(uuidgen)
export redis_password
nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST) # Getting the node names
nodes_array=( $nodes )
node_1=${nodes_array[0]}
ip=$(srun --nodes=1 --ntasks=1 -w $node_1 hostname --ip-address) # making redis-address
port=6379
ip_head=$ip:$port
export ip_head
echo "IP Head: $ip_head"
echo "STARTING HEAD at $node_1"
srun --nodes=1 --ntasks=1 -w $node_1 start-head.sh $ip $redis_password &
sleep 45
worker_num=$(($SLURM_JOB_NUM_NODES - 1)) #number of nodes other than the head node
if [ $worker_num -gt 0 ]; then
  for ((  i=1; i<=$worker_num; i++ ))
    do
      node_i=${nodes_array[$i]}
      echo "STARTING WORKER $i at $node_i"
      srun --nodes=1 --ntasks=1 -w $node_i start-worker.sh $ip_head $redis_password &
      sleep 5
    done
fi
python -u /mnt/io2/scratch_vshenoy1/chrispr/catalysis/ocp/configs/baseline_train/dimenet_plus_plus/run_tune.py --mode=train --config-yml=/mnt/io2/scratch_vshenoy1/chrispr/catalysis/ocp/configs/baseline_train/dimenet_plus_plus/dpp.yml --run_dir=/mnt/io2/scratch_vshenoy1/chrispr/catalysis/experiments/
python -u /mnt/io2/scratch_vshenoy1/chrispr/catalysis/ocp/configs/baseline_train/cgcnn/run_tune.py --mode=train --config-yml=/mnt/io2/scratch_vshenoy1/chrispr/catalysis/ocp/configs/baseline_train/cgcnn/cgcnn.yml --run_dir=/mnt/io2/scratch_vshenoy1/chrispr/catalysis/experiments/
python -u /mnt/io2/scratch_vshenoy1/chrispr/catalysis/ocp/configs/baseline_train/schnet/run_tune.py --mode=train --config-yml=/mnt/io2/scratch_vshenoy1/chrispr/catalysis/ocp/configs/baseline_train/schnet/schnet.yml --run_dir=/mnt/io2/scratch_vshenoy1/chrispr/catalysis/experiments/
ray stop
exit
