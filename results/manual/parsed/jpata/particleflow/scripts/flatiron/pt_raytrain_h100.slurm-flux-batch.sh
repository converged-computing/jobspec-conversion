#!/bin/bash
#FLUX: --job-name=pt_raytrain
#FLUX: -c=64
#FLUX: --gpus-per-task=8
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=604800
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0,1,2,3,4,5,6,7'

echo "#################### Job submission script. #############################"
cat $0
echo "################# End of job submission script. #########################"
module --force purge; module load modules/2.2-20230808
module load slurm gcc cmake cuda/12.1.1 cudnn/8.9.2.26-12.x nccl openmpi apptainer
nvidia-smi
source ~/miniconda3/bin/activate pytorch
which python3
python3 --version
export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
num_gpus=${SLURM_GPUS_PER_TASK}  # gpus per compute node
if [ "$SLURM_JOB_NUM_NODES" -gt 1 ]; then
  ################# DON NOT CHANGE THINGS HERE UNLESS YOU KNOW WHAT YOU ARE DOING ###############
  redis_password=$(uuidgen)
  export redis_password
  echo "Redis password: ${redis_password}"
  nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST) # Getting the node names
  nodes_array=( $nodes )
  node_1=${nodes_array[0]}
  ip=$(srun --nodes=1 --ntasks=1 -w $node_1 hostname --ip-address) # making redis-address
  port=6379
  ip_head=$ip:$port
  export ip_head
  echo "IP Head: $ip_head"
  echo "STARTING HEAD at $node_1"
  srun --nodes=1 --ntasks=1 -w $node_1 \
    ray start --head --node-ip-address="$node_1" --port=$port \
    --num-cpus $((SLURM_CPUS_PER_TASK)) --num-gpus $num_gpus --block &
  sleep 10
  worker_num=$(($SLURM_JOB_NUM_NODES - 1)) #number of nodes other than the head node
  for ((  i=1; i<=$worker_num; i++ ))
  do
    node_i=${nodes_array[$i]}
    echo "STARTING WORKER $i at $node_i"
    srun --nodes=1 --ntasks=1 -w $node_i \
      ray start --address "$node_1":"$port" \
      --num-cpus $((SLURM_CPUS_PER_TASK)) --num-gpus $num_gpus --block &
    sleep 5
  done
  echo All Ray workers started.
  ##############################################################################################
  # call your code below
fi
echo 'Starting training.'
python3 -u mlpf/pyg_pipeline.py --train --ray-train \
    --config $1 \
    --prefix $2 \
    --ray-cpus $((SLURM_CPUS_PER_TASK*SLURM_JOB_NUM_NODES)) \
    --gpus $((SLURM_GPUS_PER_TASK*SLURM_JOB_NUM_NODES)) \
    --gpu-batch-multiplier 4 \
    --num-workers 1 \
    --prefetch-factor 2 \
    --experiments-dir /mnt/ceph/users/ewulff/particleflow/experiments \
    --local \
    --comet
echo 'Training done.'
