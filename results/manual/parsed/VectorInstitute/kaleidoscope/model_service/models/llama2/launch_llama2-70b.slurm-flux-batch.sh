#!/bin/bash
#FLUX: --job-name=rainbow-hippo-4677
#FLUX: -N=2
#FLUX: -c=16
#FLUX: --queue=a40
#FLUX: -t=259200
#FLUX: --urgency=16

export LOGLEVEL='INFO'
export MASTER_ADDR='$(hostname -I | awk '{print $1}')'
export NCCL_IB_DISABLE='1'
export NCCL_DEBUG='INFO'

model_service_dir=$1
gateway_host=$2
gateway_port=$3
model_path="/model-weights/Llama-2-70b"
source /opt/lmod/lmod/init/profile
module load singularity-ce/3.8.2
export LOGLEVEL=INFO
export MASTER_ADDR=$(hostname -I | awk '{print $1}')
export NCCL_IB_DISABLE=1
export NCCL_DEBUG=INFO
NODES=( $( scontrol show hostnames ${SLURM_JOB_NODELIST} ) )
NODES_ARRAY=(${NODES})
HEAD_NODE=${NODES_ARRAY[0]}
HEAD_NODE_IP=$(srun --nodes=1 --ntasks=1 -w "${HEAD_NODE}" hostname --ip-address)
curl -X POST -H "Content-Type: application/json" -d '{"host": "'"$MASTER_ADDR"':51345"}' http://$gateway_host:$gateway_port/models/instances/$SLURM_JOB_NAME/register
srun -q llm \
	-p a40 \
	-N "${SLURM_JOB_NUM_NODES}" \
	--gres=gpu:4 \
	--mem=0 \
	-c 16 \
	singularity exec \
	--nv \
	--bind /checkpoint,/scratch,/fs01,/model-weights \
	/ssd005/projects/llm/llama2-latest.sif \
	torchrun \
	--nnodes 2 \
	--nproc_per_node 4 \
	--rdzv_id 9001 \
	--rdzv_backend c10d \
	--rdzv_endpoint ${HEAD_NODE_IP}:51445 \
	${model_service_dir}/model_service.py \
	--model_type llama2 \
	--model_variant 70b \
	--model_path $model_path \
	--model_instance_id $SLURM_JOB_NAME \
	--gateway_host $gateway_host \
	--gateway_port $gateway_port \
	--master_host $MASTER_ADDR \
	--master_port 51345
