#!/bin/bash
#FLUX: --job-name=gloopy-snack-5286
#FLUX: -N=24
#FLUX: -c=256
#FLUX: --exclusive
#FLUX: --queue=dc-gpu
#FLUX: -t=86400
#FLUX: --urgency=16

export TUNE_RESULT_DIR='/p/project/raise-ctp2/cern/ray_results/tune_result_dir'
export TUNE_MAX_PENDING_TRIALS_PG='$(($SLURM_NNODES * 4))'
export TUNE_DISABLE_STRICT_METRIC_CHECKING='1'
export CUDA_VISIBLE_DEVICES='0,1,2,3'

echo "#################### Job submission script. #############################"
cat $0
echo "################# End of job submission script. #########################"
set -x
export TUNE_RESULT_DIR="/p/project/raise-ctp2/cern/ray_results/tune_result_dir"
export TUNE_MAX_PENDING_TRIALS_PG=$(($SLURM_NNODES * 4))
export TUNE_DISABLE_STRICT_METRIC_CHECKING=1
module purge
module load GCC GCCcore/.11.2.0 CMake NCCL CUDA cuDNN OpenMPI
export CUDA_VISIBLE_DEVICES=0,1,2,3
num_gpus=4
jutil env activate -p raise-ctp2
nvidia-smi
source /p/project/raise-ctp2/cern/miniconda3/bin/activate tf2
echo "Python used:"
which python3
python3 --version
redis_password=$(uuidgen)
export redis_password
echo "Redis password: ${redis_password}"
nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST) # Getting the node names
nodes_array=( $nodes )
node_1=${nodes_array[0]}
ip=$(srun --nodes=1 --ntasks=1 -w $node_1 host ${node_1}i | awk '{ print $4 }') # making redis-address
sleep 1
port=6379
ip_head=$ip:$port
export ip_head
echo "IP Head: $ip_head"
echo "STARTING HEAD at $node_1"
srun --nodes=1 --ntasks=1 -w $node_1 \
  ray start --head --node-ip-address="$node_1"i --port=$port \
  --num-cpus "${SLURM_CPUS_PER_TASK}" --num-gpus $num_gpus --block &  # mlpf/raytune/start-head.sh $ip $port &
sleep 10
worker_num=$(($SLURM_JOB_NUM_NODES - 1)) #number of nodes other than the head node
for ((  i=1; i<=$worker_num; i++ ))
do
  node_i=${nodes_array[$i]}
  echo "STARTING WORKER $i at $node_i"
  srun --nodes=1 --ntasks=1 -w $node_i \
    ray start --address "$node_1"i:"$port" \
    --num-cpus "${SLURM_CPUS_PER_TASK}" --num-gpus $num_gpus --block &  # mlpf/raytune/start-worker.sh $ip_head &
  sleep 5
done
echo All Ray workers started.
python3 mlpf/pipeline.py raytune -c $1 -n $2 -s --cpus "${SLURM_CPUS_PER_TASK}" --gpus $num_gpus  -r # --cpus 64 --gpus 1 -r
exit
