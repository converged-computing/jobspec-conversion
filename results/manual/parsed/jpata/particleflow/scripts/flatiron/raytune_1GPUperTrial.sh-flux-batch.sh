#!/bin/bash
#FLUX: --job-name=raytune
#FLUX: -N=8
#FLUX: -c=64
#FLUX: --gpus-per-task=4
#FLUX: --queue=gpu
#FLUX: -t=604800
#FLUX: --urgency=16

export TUNE_RESULT_DIR='/mnt/ceph/users/ewulff/ray_results/tune_result_dir'
export TUNE_MAX_PENDING_TRIALS_PG='$((SLURM_NNODES*2))'
export CUDA_VISIBLE_DEVICES='0,1,2,3'

echo "#################### Job submission script. #############################"
cat $0
echo "################# End of job submission script. #########################"
set -x
export TUNE_RESULT_DIR="/mnt/ceph/users/ewulff/ray_results/tune_result_dir"
export TUNE_MAX_PENDING_TRIALS_PG=$((SLURM_NNODES*2))
module --force purge; module load modules/2.0-20220630
module load slurm gcc cmake/3.22.3 nccl cuda/11.4.4 cudnn/8.2.4.15-11.4 openmpi/4.0.7
nvidia-smi
export CUDA_VISIBLE_DEVICES=0,1,2,3
num_gpus=4
source ~/miniconda3/bin/activate tf2
echo "Python used:"
which python3
python3 --version
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
  --num-cpus $((SLURM_CPUS_PER_TASK)) --num-gpus $num_gpus --block &  # mlpf/raytune/start-head.sh $ip $port &
sleep 10
worker_num=$(($SLURM_JOB_NUM_NODES - 1)) #number of nodes other than the head node
for ((  i=1; i<=$worker_num; i++ ))
do
  node_i=${nodes_array[$i]}
  echo "STARTING WORKER $i at $node_i"
  srun --nodes=1 --ntasks=1 -w $node_i \
    ray start --address "$node_1":"$port" \
    --num-cpus $((SLURM_CPUS_PER_TASK)) --num-gpus $num_gpus --block &  # mlpf/raytune/start-worker.sh $ip_head &
  sleep 5
done
echo All Ray workers started.
python3 mlpf/pipeline.py raytune -c $1 -n $2 --cpus $((SLURM_CPUS_PER_TASK/4)) \
  --gpus 1 --seeds --comet-exp-name particleflow-raytune
  # --ntrain 100 --ntest 100 #--comet-online
exit
