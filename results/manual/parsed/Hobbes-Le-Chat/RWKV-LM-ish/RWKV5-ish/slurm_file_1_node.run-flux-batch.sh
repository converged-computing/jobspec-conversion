#!/bin/bash
#FLUX: --job-name=RWKV-Cr
#FLUX: -c=3
#FLUX: --queue=batch
#FLUX: -t=1200
#FLUX: --urgency=16

export ROCM_HOME='/opt/rocm-5.6.0'
export TRANSFORMERS_OFFLINE='1'
export HF_DATASETS_OFFLINE='1'
export OMP_NUM_THREADS='1'
export NCCL_DEBUG='INFO'
export FI_CXI_ATS='0'
export LD_LIBRARY_PATH='/opt/rocm-5.6.0/rccl/build:$PWD/aws-ofi-rccl/src/.libs/:/opt/cray/libfabric/1.15.2.0/lib64/:/opt/rocm-5.6.0/lib'
export FI_LOG_LEVEL='info'
export NCCL_NET_GDR_LEVEL='3'
export MASTER_ADDR='${arr[0]}'
export MASTER_PORT='32768'
export https_proxy='https://proxy.ccs.ornl.gov:3128'
export http_proxy='http://proxy.ccs.ornl.gov:3128'
export WANDB_MODE='offline'
export WANDB_RUN_GROUP='TEST_EXPERIMENT-ROCM-SLURM'

source ../../parameters_cr.sh
module load PrgEnv-gnu
module load gcc/11.2.0
module load rocm/5.6.0
export ROCM_HOME=/opt/rocm-5.6.0
export TRANSFORMERS_OFFLINE=1
export HF_DATASETS_OFFLINE=1
export OMP_NUM_THREADS=1
HOSTS=.hosts-job$SLURM_JOB_ID
HOSTFILE=hostfile.txt
srun hostname > $HOSTS
sed 's/$/ slots=8/' $HOSTS > $HOSTFILE
echo "PATH=$PATH" > .deepspeed_env
echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH" >> .deepspeed_env
echo "CPATH=$CPATH" >> .deepspeed_env
echo "TORCH_EXTENSIONS_DIR=$TORCH_EXTENSIONS_DIR" >> .deepspeed_env
echo "ROCM_HOME=/opt/rocm-5.6.0" >> .deepspeed_env
export NCCL_DEBUG=INFO
export FI_CXI_ATS=0
export LD_LIBRARY_PATH=/opt/rocm-5.6.0/rccl/build:$PWD/aws-ofi-rccl/src/.libs/:/opt/cray/libfabric/1.15.2.0/lib64/:/opt/rocm-5.6.0/lib
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
export MASTER_PORT=32768
ranks_per_node=8
gpus_per_rank=$((8/$ranks_per_node))
ranks_total=$(($ranks_per_node*$SLURM_JOB_NUM_NODES))
if [[ ! -d "logs" ]]; then
    # Create the logs directory
    mkdir -p "logs"
fi
if [[ ! -d "logs/rwkvlm" ]]; then
    # Create the logs/rwkvlm directory
    mkdir -p "logs/rwkvlm"
fi
projout="progress${SLURM_JOB_NUM_NODES}"
if [[ ! -d $projout ]]; then
    # Create the proj_dir directory
    mkdir -p $projout
fi
export https_proxy=https://proxy.ccs.ornl.gov:3128
export http_proxy=http://proxy.ccs.ornl.gov:3128
info_file="logs/resource_info-${SLURM_JOB_ID}.txt"
echo "Job ID: $SLURM_JOB_ID" > $info_file
echo "Job Name: $SLURM_JOB_NAME" >> $info_file
echo "Allocated Nodes: $SLURM_JOB_NUM_NODES" >> $info_file
echo "Node List: $SLURM_JOB_NODELIST" >> $info_file
echo "Partition: $SLURM_JOB_PARTITION" >> $info_file
echo "CPU Count: $SLURM_CPUS_ON_NODE" >> $info_file
echo "Allocated Memory: $SLURM_MEM_PER_NODE" >> $info_file
echo "Working Directory: $SLURM_SUBMIT_DIR" >> $info_file
echo "Allocated GPUs: $SLURM_JOB_GPUS" >> $info_file
echo "Allocated GPU String: $SLURM_JOB_GPUS_STRING" >> $info_file
export WANDB_MODE=offline
export WANDB_RUN_GROUP="TEST_EXPERIMENT-ROCM-SLURM"
time srun --cpu_bind=v python3 train.py --wandb "test-${SLURM_JOB_NUM_NODES}N" --load_model "" --proj_dir $projout --data_file "../../rwkv5-world-slimpajama-1_text_document_1" --data_type "binidx" --vocab_size 65536 --ctx_len 4096 --epoch_steps 100 --epoch_count 10 --epoch_begin 0 --epoch_save 5 --micro_bsz 8 --n_layer 32 --n_embd 4096 --pre_ffn 0 --head_qk 0 --lr_init 5e-5 --lr_final 1e-5 --warmup_steps 0 --beta1 0.9 --beta2 0.999 --adam_eps 1e-8 --accelerator gpu --devices 8 --num_nodes $SLURM_JOB_NUM_NODES --precision bf16 --strategy deepspeed_stage_3 --grad_cp 1
