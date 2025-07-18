#!/bin/bash
#FLUX: --job-name=gpt_frontier
#FLUX: -N=2
#FLUX: --queue=batch
#FLUX: -t=1200
#FLUX: --urgency=16

export LD_PRELOAD='/usr/lib64/libcrypto.so /usr/lib64/libssh.so.4 /usr/lib64/libssl.so.1.1'
export ROCM_HOME='/opt/rocm-5.4.0'
export TRANSFORMERS_OFFLINE='1'
export HF_DATASETS_OFFLINE='1'
export TORCH_EXTENSIONS_DIR='$PWD/deepspeed'
export HF_HOME='$PWD/hfdata'
export OMP_NUM_THREADS='2'
export NCCL_DEBUG='INFO'
export FI_CXI_ATS='0'
export LD_LIBRARY_PATH='/opt/rocm-5.4.0/rccl/build:$PWD/aws-ofi-rccl/src/.libs/:/opt/cray/libfabric/1.15.2.0/lib64/:/opt/rocm-5.4.0/lib'
export FI_LOG_LEVEL='info'
export NCCL_NET_GDR_LEVEL='3'
export MASTER_ADDR='${arr[0]}'
export https_proxy='https://proxy.ccs.ornl.gov:3128'
export http_proxy='http://proxy.ccs.ornl.gov:3128'

set +x
source /lustre/orion/world-shared/stf218/sajal/miniconda3/bin/activate
conda activate /lustre/orion/world-shared/stf218/sajal/TORCH2/env-py310-rccl
export LD_PRELOAD="/usr/lib64/libcrypto.so /usr/lib64/libssh.so.4 /usr/lib64/libssl.so.1.1"
module load PrgEnv-gnu
module load gcc/11.2.0
module load rocm/5.4.0
export ROCM_HOME=/opt/rocm-5.4.0
export TRANSFORMERS_OFFLINE=1
export HF_DATASETS_OFFLINE=1
export TORCH_EXTENSIONS_DIR=$PWD/deepspeed
export HF_HOME=$PWD/hfdata
export OMP_NUM_THREADS=1
HOSTS=.hosts-job$SLURM_JOB_ID
HOSTFILE=hostfile.txt
srun hostname > $HOSTS
sed 's/$/ slots=8/' $HOSTS > $HOSTFILE
echo "PATH=$PATH" > .deepspeed_env
echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH" >> .deepspeed_env
echo "CPATH=$CPATH" >> .deepspeed_env
echo "TORCH_EXTENSIONS_DIR=$PWD/deepspeed" >> .deepspeed_env
echo "HF_HOME=$PWD/hfdata" >> .deepspeed_env
echo "ROCM_HOME=/opt/rocm-5.4.0" >> .deepspeed_env
export NCCL_DEBUG=INFO
export FI_CXI_ATS=0
export LD_LIBRARY_PATH=/opt/rocm-5.4.0/rccl/build:$PWD/aws-ofi-rccl/src/.libs/:/opt/cray/libfabric/1.15.2.0/lib64/:/opt/rocm-5.4.0/lib
export FI_LOG_LEVEL=info
export NCCL_NET_GDR_LEVEL=3
scontrol show hostnames $SLURM_NODELIST > job.node.list
input="./job.node.list"
readarray -t arr <"$input"
first=${arr[0]}
echo "first=" $first
ips=`ssh $first hostname -I`
read -ra arr <<< ${ips}
export MASTER_ADDR=${arr[0]}
echo "MASTER_ADDR=" $MASTER_ADDR
ranks_per_node=8
gpus_per_rank=$((8/$ranks_per_node))
ranks_total=$(($ranks_per_node*$SLURM_JOB_NUM_NODES))
mkdir logs
mkdir logs/transformer
export https_proxy=https://proxy.ccs.ornl.gov:3128
export http_proxy=http://proxy.ccs.ornl.gov:3128
export OMP_NUM_THREADS=2
srun -u -n$ranks_total -c2 --ntasks-per-node=8 --gpus-per-node=8 --gpu-bind=closest python gptJ_oscar_fsdp.py \
   --output_dir ./outputs \
   --do_train=True \
   --per_device_train_batch_size 4 \
   --max_len 128 \
   --learning_rate 0.0002 \
   --adam_beta2 0.98 \
   --weight_decay 0.0000 \
   --adam_epsilon 1e-8 \
   --max_steps 100 \
   --warmup_steps 10 \
   --master_addr=$MASTER_ADDR
