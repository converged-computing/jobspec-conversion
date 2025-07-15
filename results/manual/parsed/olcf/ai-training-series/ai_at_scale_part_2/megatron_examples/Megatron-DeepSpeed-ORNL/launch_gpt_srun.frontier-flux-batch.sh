#!/bin/bash
#FLUX: --job-name=boopy-carrot-2820
#FLUX: --urgency=16

export LD_PRELOAD='/usr/lib64/libcrypto.so /usr/lib64/libssh.so.4 /usr/lib64/libssl.so.1.1'
export ROCM_HOME='/opt/rocm-5.4.0'
export TRANSFORMERS_OFFLINE='1'
export HF_DATASETS_OFFLINE='1'
export NCCL_DEBUG='INFO'
export TORCH_EXTENSIONS_DIR='$PWD/deepspeed'
export HF_HOME='$PWD/hfdata'
export OMP_NUM_THREADS='1'
export MASTER_ADDR='${arr[0]}'
export CHECKPOINT_PATH='checkpoints/gpt2_345m'
export VOCAB_FILE='gpt2-vocab.json'
export MERGE_FILE='gpt2-merges.txt'
export DATA_PATH='/lustre/orion/world-shared/stf218/sajal/mtds/gptdata/gpttext_article_document'
export GPT_ARGS='--tensor-model-parallel-size 8 \'
export OUTPUT_ARGS='--log-interval 10 \'
export CUDA_DEVICE_MAX_CONNECTIONS='1'
export CUDA_VISIBLE_DEVICES='0,1,2,3,4,5,6,7'

set +x
source /lustre/orion/world-shared/stf218/sajal/miniconda3/bin/activate
conda activate /lustre/orion/world-shared/stf218/sajal/TORCH2/env-py310-rccl-megatron-new
export LD_PRELOAD="/usr/lib64/libcrypto.so /usr/lib64/libssh.so.4 /usr/lib64/libssl.so.1.1"
module load PrgEnv-gnu
module load gcc/11.2.0
module load rocm/5.4.0
export ROCM_HOME=/opt/rocm-5.4.0
export TRANSFORMERS_OFFLINE=1
export HF_DATASETS_OFFLINE=1
export NCCL_DEBUG=INFO
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
echo $ranks_per_node $gpus_per_rank $ranks_total
mkdir logs
mkdir logs/transformer
export CHECKPOINT_PATH=checkpoints/gpt2_345m
export VOCAB_FILE=gpt2-vocab.json
export MERGE_FILE=gpt2-merges.txt
export DATA_PATH=/lustre/orion/world-shared/stf218/sajal/mtds/gptdata/gpttext_article_document
export GPT_ARGS="--tensor-model-parallel-size 8 \
          --pipeline-model-parallel-size 2 \
          --num-layers 24 \
          --hidden-size 2064 \
          --num-attention-heads 24 \
          --seq-length 2048 \
          --max-position-embeddings 2048 \
          --micro-batch-size 2 \
          --lr 0.00015 \
          --train-iters 1000 \
          --lr-decay-iters 50 \
          --lr-decay-style cosine \
          --vocab-file $VOCAB_FILE \
          --merge-file $MERGE_FILE \
          --lr-warmup-fraction .01 \
"
          #--fp16"
export OUTPUT_ARGS="--log-interval 10 \
             --save-interval 500 \
             --eval-interval 100 \
             --eval-iters 10"
export CUDA_DEVICE_MAX_CONNECTIONS=1
export OMP_NUM_THREADS=1
export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
time srun -u -n$ranks_total -c2 --ntasks-per-node=8 --gpus-per-node=8 --gpu-bind=closest bash -c "
source export_DDP_vars.sh
python pretrain_gpt_deepspeed.py \
       $GPT_ARGS \
       $OUTPUT_ARGS \
       --save $CHECKPOINT_PATH \
       --data-path $DATA_PATH \
       --master-addr=$MASTER_ADDR \
       --data-path $DATA_PATH \
       --num-workers 0 \
       --tensorboard-dir logs/profiles-with-zero-0 \
       --deepspeed \
       --zero-stage 0 \
       --deepspeed_config ds_config.json \
       --deepspeed-activation-checkpointing \
       --checkpoint-activations
"
      # --master-addr=$MASTER_ADDR
