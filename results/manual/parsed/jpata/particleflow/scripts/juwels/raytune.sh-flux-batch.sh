#!/bin/bash
#FLUX: --job-name=persnickety-lizard-5907
#FLUX: -N=12
#FLUX: -c=96
#FLUX: --gpus-per-task=4
#FLUX: --queue=booster
#FLUX: -t=21600
#FLUX: --priority=16

export TUNE_RESULT_DIR='/p/project/prcoe12/wulff1/ray_results/tune_result_dir'
export TUNE_MAX_PENDING_TRIALS_PG='${SLURM_NNODES}'
export CUDA_VISIBLE_DEVICES='0,1,2,3'

echo "#################### Job submission script. #############################"
cat $0
echo "################# End of job submission script. #########################"
export TUNE_RESULT_DIR="/p/project/prcoe12/wulff1/ray_results/tune_result_dir"
export TUNE_MAX_PENDING_TRIALS_PG=${SLURM_NNODES}
module purge
module load GCC/10.3.0 CUDA/11.0 cuDNN/8.0.2.39-CUDA-11.0
export CUDA_VISIBLE_DEVICES=0,1,2,3
jutil env activate -p prcoe12
nvidia-smi
source /p/project/prcoe12/wulff1/miniconda3/bin/activate tf2
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
port=6379
ip_head=$ip:$port
export ip_head
echo "IP Head: $ip_head"
echo "STARTING HEAD at $node_1"
srun --nodes=1 --ntasks=1 -w $node_1 mlpf/raytune/start-head.sh $ip $SLURM_JOB_ID $2 "/p/project/prcoe12/wulff1/nvidia_smi_logs/" &
sleep 30
worker_num=$(($SLURM_JOB_NUM_NODES - 1)) #number of nodes other than the head node
for ((  i=1; i<=$worker_num; i++ ))
do
  node_i=${nodes_array[$i]}
  echo "STARTING WORKER $i at $node_i"
  srun --nodes=1 --ntasks=1 -w ${node_i} mlpf/raytune/start-worker.sh $ip_head $SLURM_JOB_ID $i $2 "/p/project/prcoe12/wulff1/nvidia_smi_logs/" &
  sleep 5
done
python3 mlpf/pipeline.py raytune -c $1 -n $2 --cpus "${SLURM_CPUS_PER_TASK}" --gpus "${SLURM_GPUS_PER_TASK}" -r
exit
