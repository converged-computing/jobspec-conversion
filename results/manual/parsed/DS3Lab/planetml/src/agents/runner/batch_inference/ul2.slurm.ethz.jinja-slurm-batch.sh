#!/bin/bash
#FLUX: --job-name=ul2
#FLUX: -c=2
#FLUX: -t=14340
#FLUX: --urgency=16

export NCCL_SOCKET_IFNAME='access'
export GLOO_SOCKET_IFNAME='access'
export NCCL_DEBUG='INFO'
export NCCL_IB_DISABLE='1'
export NCCL_P2P_DISABLE='1'

. /cluster/apps/local/env2lmod.sh
module load gcc/8.2.0 python_gpu/3.9.9 cuda/11.0.3 eth_proxy zsh/5.8
source /nfs/iiscratch-zhang.inf.ethz.ch/export/zhang/export/fm/new/planetml_env/bin/activate
cd /nfs/iiscratch-zhang.inf.ethz.ch/export/zhang/export/fm/GPT-home-private      # Change directory
job_id=$1
echo job_id $job_id
world_size=16
DIST_CONF="--pp-mode pipe_async_sample_enc_dec_mask --pipeline-group-size $world_size --cuda-id 0"
MODEL_CONF="--model-type t5 --model-name /nfs/iiscratch-zhang.inf.ethz.ch/export/zhang/export/fm/pretrained_models/ul2-new --num-iters 99999999999"
INFERENCE_CONF="--budget 10800 --num-layers 2"
COOR_CONF="--coordinator-server-ip 10.6.7.244 --working-directory /nfs/iiscratch-zhang.inf.ethz.ch/export/zhang/export/fm/new/working_dir --profiling no-profiling  --net-interface access --job_id $job_id"
export NCCL_SOCKET_IFNAME=access
export GLOO_SOCKET_IFNAME=access
export NCCL_DEBUG=INFO
export NCCL_IB_DISABLE=1
export NCCL_P2P_DISABLE=1
python -u dist_batch_and_latency_inference_w_httpclient.py $DIST_CONF $MODEL_CONF $INFERENCE_CONF $COOR_CONF
