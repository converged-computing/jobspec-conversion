#!/bin/bash
#FLUX: --job-name=hypertune
#FLUX: -N=4
#FLUX: --queue=booster
#FLUX: -t=86399
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0,1,2,3'

echo "#################### Job submission script. #############################"
cat $0
echo "################# End of job submission script. #########################"
module purge
module load GCC/10.3.0 CUDA/11.0 cuDNN/8.0.2.39-CUDA-11.0
export CUDA_VISIBLE_DEVICES=0,1,2,3
jutil env activate -p prcoe12
nvidia-smi
source /p/project/prcoe12/wulff1/miniconda3/bin/activate tf2
echo "Python used:"
which python3
python3 --version
nodes=$(scontrol show hostnames "$SLURM_JOB_NODELIST")
nodes_array=($nodes)
echo "Using nodes:"
echo $nodes
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)
if [[ "$head_node_ip" == *" "* ]]; then
IFS=' ' read -ra ADDR <<<"$head_node_ip"
if [[ ${#ADDR[0]} -gt 16 ]]; then
  head_node_ip=${ADDR[1]}
else
  head_node_ip=${ADDR[0]}
fi
echo "IPV6 address detected. We split the IPV4 address as $head_node_ip"
fi
port=6379
ip_head=$head_node_ip:$port
export ip_head
echo "IP Head: $ip_head"
echo "Starting HEAD at $head_node"
srun --nodes=1 --ntasks=1 -w "$head_node" mlpf/hypertune_scripts/run_chief.sh "chief" $head_node_ip $port $1 "/p/project/prcoe12/wulff1/hypertunes/hypertune_out${2}_${SLURM_JOB_ID}" &> logs_slurm/chief_${SLURM_JOB_ID} &
sleep 5
worker_num=$((SLURM_JOB_NUM_NODES - 1))
for ((i = 1; i <= worker_num; i++)); do
    node_i=${nodes_array[$i]}
    echo "Starting WORKER $i at $node_i"
    tunerID="tuner$i"
    srun --nodes=1 --ntasks=1 -w "$node_i" \
        mlpf/hypertune_scripts/run_tuner.sh $tunerID $head_node_ip $port $1 "/p/project/prcoe12/wulff1/hypertunes/hypertune_out${2}_${SLURM_JOB_ID}" &> logs_slurm/tuner_${SLURM_JOB_ID}_${i} &
    sleep 1
done
wait # keep the wait statement, it is important!
echo "Done."
