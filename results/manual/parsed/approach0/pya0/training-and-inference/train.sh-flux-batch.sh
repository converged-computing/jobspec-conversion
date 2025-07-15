#!/bin/bash
#FLUX: --job-name=confused-earthworm-0136
#FLUX: -N=4
#FLUX: -c=2
#FLUX: -t=345730
#FLUX: --urgency=16

export NCCL_BLOCKING_WAIT='1  # Set this variable to use the NCCL backend'
export NCCL_IB_DISABLE='1'
export NCCL_DEBUG='INFO'
export NCCL_P2P_DISABLE='1'
export SLURM_ACCOUNT='def-jimmylin'
export SBATCH_ACCOUNT='$SLURM_ACCOUNT'
export SALLOC_ACCOUNT='$SLURM_ACCOUNT'
export TORCH_DISTRIBUTED_DEBUG='OFF #DETAIL'

set -x
TRAINER=${1-pretrain}
SETUP=${2}
DEVICES=${3-0} # only needed for local training (non-Slurm)
SAVE_PREFIX='./models'
{
DATE=$(date)
CODE_VER=$(test -e pya0 && cd pya0 && pwd && git rev-parse HEAD)
COMMAND="$0 $@"
EPOCHS=10
TEST_CYCLE=100
case $TRAINER-${SETUP} in
   pretrain-bertnsp-a6000)
    DEV_BSIZE=32 # to be comparable to MAEs
    SAVE_FOLD=1
    DATA_VER=oEkdGxJgWmEESPQ
    START_POINT=bert-base-uncased
    TOK_CKPOINT=math-tokenizer
    SHARDS_LIST=shards.txt
    TEST_FILE=test.txt
    TEST_CYCLE=100
    CALL_ARGS=
    TRAINER_ARGS="--architecture standard --warmup-epochs 1 --lr 1e-4"
    ;;
   pretrain-cotbert-a6000)
    DEV_BSIZE=16
    SAVE_FOLD=1
    DATA_VER=FaMd9n9FN4rMzwR
    START_POINT=bert-base-uncased
    TOK_CKPOINT=math-tokenizer
    SHARDS_LIST=shards.txt
    TEST_FILE=test.txt
    TEST_CYCLE=100
    CALL_ARGS=
    TRAINER_ARGS="--architecture cotbert --warmup-epochs 1 --lr 1e-4"
    ;;
   pretrain-condenser-a6000)
    DEV_BSIZE=16
    SAVE_FOLD=1
    DATA_VER=FaMd9n9FN4rMzwR
    START_POINT=bert-base-uncased
    TOK_CKPOINT=math-tokenizer
    SHARDS_LIST=shards.txt
    TEST_FILE=test.txt
    TEST_CYCLE=100
    CALL_ARGS=
    TRAINER_ARGS="--architecture condenser --warmup-epochs 1 --lr 1e-4"
    ;;
   pretrain-cocondenser-a6000)
    DEV_BSIZE=16
    SAVE_FOLD=1
    DATA_VER=FaMd9n9FN4rMzwR
    START_POINT=bert-base-uncased
    TOK_CKPOINT=math-tokenizer
    SHARDS_LIST=shards.txt
    TEST_FILE=test.txt
    TEST_CYCLE=100
    CALL_ARGS=
    TRAINER_ARGS="--architecture cocondenser --warmup-epochs 1 --lr 1e-4"
    ;;
   pretrain-cotmae-a6000)
    DEV_BSIZE=16
    SAVE_FOLD=1
    DATA_VER=FaMd9n9FN4rMzwR
    START_POINT=bert-base-uncased
    TOK_CKPOINT=math-tokenizer
    SHARDS_LIST=shards.txt
    TEST_FILE=test.txt
    TEST_CYCLE=100
    CALL_ARGS=
    TRAINER_ARGS="--architecture cotmae --warmup-epochs 1 --lr 1e-4"
    ;;
   pretrain-cocomae-a6000)
    DEV_BSIZE=16
    SAVE_FOLD=1
    DATA_VER=FaMd9n9FN4rMzwR
    START_POINT=bert-base-uncased
    TOK_CKPOINT=math-tokenizer
    SHARDS_LIST=shards.txt
    TEST_FILE=test.txt
    TEST_CYCLE=100
    CALL_ARGS=
    TRAINER_ARGS="--architecture cocomae --warmup-epochs 1 --lr 1e-4"
    ;;
   single_vec_retriever-a6000-using-vanilla-bert)
    DEV_BSIZE=18
    SAVE_FOLD=1
    DATA_VER=yfEdE6sensBpCxT
    START_POINT=bert-base-uncased
    TOK_CKPOINT=math-tokenizer
    SHARDS_LIST=shards.txt
    TEST_FILE=test.txt
    TEST_CYCLE=0 # 300
    CALL_ARGS=
    TRAINER_ARGS="--warmup-epochs 1 --lr 2e-5"
    ;;
   single_vec_retriever-a6000-using-bertnsp)
    DEV_BSIZE=18
    SAVE_FOLD=1
    DATA_VER=yfEdE6sensBpCxT
    START_POINT=models/job-pretrain-bertnsp-a6000-pretrain/6-0-0
    TOK_CKPOINT=math-tokenizer
    SHARDS_LIST=shards.txt
    TEST_FILE=test.txt
    TEST_CYCLE=0 # 300
    CALL_ARGS=
    TRAINER_ARGS="--warmup-epochs 1 --lr 2e-5"
    ;;
   single_vec_retriever-a6000-using-cotbert)
    DEV_BSIZE=18
    SAVE_FOLD=1
    DATA_VER=yfEdE6sensBpCxT
    START_POINT=models/job-pretrain-cotbert-a6000-pretrain/6-0-0/encoder.ckpt
    TOK_CKPOINT=math-tokenizer
    SHARDS_LIST=shards.txt
    TEST_FILE=test.txt
    TEST_CYCLE=0 # 300
    CALL_ARGS=
    TRAINER_ARGS="--warmup-epochs 1 --lr 2e-5"
    ;;
   single_vec_retriever-a6000-using-cotmae)
    DEV_BSIZE=18
    SAVE_FOLD=1
    DATA_VER=yfEdE6sensBpCxT
    START_POINT=models/job-pretrain-cotmae-a6000-pretrain/6-0-0/encoder.ckpt
    TOK_CKPOINT=math-tokenizer
    SHARDS_LIST=shards.txt
    TEST_FILE=test.txt
    TEST_CYCLE=0 # 300
    CALL_ARGS=
    TRAINER_ARGS="--warmup-epochs 1 --lr 2e-5"
    ;;
   single_vec_retriever-a6000-using-cocondenser)
    DEV_BSIZE=18
    SAVE_FOLD=1
    DATA_VER=yfEdE6sensBpCxT
    START_POINT=models/job-pretrain-cocondenser-a6000-pretrain/6-0-0/encoder.ckpt
    TOK_CKPOINT=math-tokenizer
    SHARDS_LIST=shards.txt
    TEST_FILE=test.txt
    TEST_CYCLE=0 # 300
    CALL_ARGS=
    TRAINER_ARGS="--warmup-epochs 1 --lr 2e-5"
    ;;
   single_vec_retriever-a6000-using-cocomae)
    DEV_BSIZE=18
    SAVE_FOLD=1
    DATA_VER=yfEdE6sensBpCxT
    START_POINT=models/job-pretrain-cocomae-a6000-pretrain/6-0-0/encoder.ckpt
    TOK_CKPOINT=math-tokenizer
    SHARDS_LIST=shards.txt
    TEST_FILE=test.txt
    TEST_CYCLE=0 # 300
    CALL_ARGS=
    TRAINER_ARGS="--warmup-epochs 1 --lr 2e-5"
    ;;
   single_vec_retriever-a6000-using-math-aware-albert)
    DEV_BSIZE=18
    SAVE_FOLD=1
    DATA_VER=gkdLZeb2diEwMbt
    START_POINT=AnReu/math_albert
    TOK_CKPOINT=AnReu/math_albert
    SHARDS_LIST=shards.txt
    TEST_FILE=test.txt
    TEST_CYCLE=0 # 300
    CALL_ARGS= 
    TRAINER_ARGS="--architecture albert --warmup-epochs 1 --lr 2e-5"
    ;;
   colbert-a6000-using-bertnsp)
    EPOCHS=8
    DEV_BSIZE=18 # 20 is still ok, but just to match the DPRs...
    SAVE_FOLD=1
    DATA_VER=yfEdE6sensBpCxT
    START_POINT=models/job-pretrain-bertnsp-a6000-pretrain/6-0-0
    TOK_CKPOINT=math-tokenizer
    SHARDS_LIST=shards.txt
    TEST_FILE=test.txt
    TEST_CYCLE=0 # 300
    CALL_ARGS="512" # qmax
    TRAINER_ARGS="--warmup-epochs 1 --lr 2e-5 --active_fp16"
    ;;
   colbert-a6000-using-cocomae)
    EPOCHS=8
    DEV_BSIZE=18 # 20 is still ok, but just to match the DPRs...
    SAVE_FOLD=1
    DATA_VER=yfEdE6sensBpCxT
    START_POINT=models/job-pretrain-cocomae-a6000-pretrain/6-0-0/encoder.ckpt
    TOK_CKPOINT=math-tokenizer
    SHARDS_LIST=shards.txt
    TEST_FILE=test.txt
    TEST_CYCLE=0 # 300
    CALL_ARGS="512" # qmax
    TRAINER_ARGS="--warmup-epochs 1 --lr 2e-5 --active_fp16"
    ;;
   single_vec_retriever-splade_all-a6000-using-bertnsp)
    DEV_BSIZE=12
    SAVE_FOLD=1
    DATA_VER=yfEdE6sensBpCxT
    START_POINT=models/job-pretrain-bertnsp-a6000-pretrain/6-0-0
    TOK_CKPOINT=math-tokenizer
    SHARDS_LIST=shards.txt
    TEST_FILE=test.txt
    TEST_CYCLE=0 # 300
    CALL_ARGS=
    TRAINER_ARGS="--architecture splade --splade_reg 1e-4 --splade_mask_mode all --warmup-epochs 1 --lr 2e-5"
    ;;
   single_vec_retriever-splade_somemath-a6000-using-bertnsp)
    DEV_BSIZE=12
    SAVE_FOLD=1
    DATA_VER=yfEdE6sensBpCxT
    START_POINT=models/job-pretrain-bertnsp-a6000-pretrain/6-0-0
    TOK_CKPOINT=math-tokenizer
    SHARDS_LIST=shards.txt
    TEST_FILE=test.txt
    TEST_CYCLE=0 # 300
    CALL_ARGS=
    TRAINER_ARGS="--architecture splade --splade_reg 1e-4 --splade_mask_mode somemath --warmup-epochs 1 --lr 2e-5"
    ;;
   single_vec_retriever-splade_nomath-a6000-using-bertnsp)
    DEV_BSIZE=12
    SAVE_FOLD=1
    DATA_VER=yfEdE6sensBpCxT
    START_POINT=models/job-pretrain-bertnsp-a6000-pretrain/6-0-0
    TOK_CKPOINT=math-tokenizer
    SHARDS_LIST=shards.txt
    TEST_FILE=test.txt
    TEST_CYCLE=0 # 300
    CALL_ARGS=
    TRAINER_ARGS="--architecture splade --splade_reg 1e-4 --splade_mask_mode nomath --warmup-epochs 1 --lr 2e-5"
    ;;
   single_vec_retriever-splade_all-a6000-using-cocomae)
    DEV_BSIZE=12
    SAVE_FOLD=1
    DATA_VER=yfEdE6sensBpCxT
    START_POINT=models/job-pretrain-cocomae-a6000-pretrain/6-0-0/encoder.ckpt
    TOK_CKPOINT=math-tokenizer
    SHARDS_LIST=shards.txt
    TEST_FILE=test.txt
    TEST_CYCLE=0 # 300
    CALL_ARGS=
    TRAINER_ARGS="--architecture splade --splade_reg 1e-4 --splade_mask_mode all --warmup-epochs 1 --lr 2e-5"
    ;;
   single_vec_retriever-splade_somemath-a6000-using-cocomae)
    DEV_BSIZE=12
    SAVE_FOLD=1
    DATA_VER=yfEdE6sensBpCxT
    START_POINT=models/job-pretrain-cocomae-a6000-pretrain/6-0-0/encoder.ckpt
    TOK_CKPOINT=math-tokenizer
    SHARDS_LIST=shards.txt
    TEST_FILE=test.txt
    TEST_CYCLE=0 # 300
    CALL_ARGS=
    TRAINER_ARGS="--architecture splade --splade_reg 1e-4 --splade_mask_mode somemath --warmup-epochs 1 --lr 2e-5"
    ;;
   single_vec_retriever-splade_nomath-a6000-using-cocomae)
    DEV_BSIZE=12
    SAVE_FOLD=1
    DATA_VER=yfEdE6sensBpCxT
    START_POINT=models/job-pretrain-cocomae-a6000-pretrain/6-0-0/encoder.ckpt
    TOK_CKPOINT=math-tokenizer
    SHARDS_LIST=shards.txt
    TEST_FILE=test.txt
    TEST_CYCLE=0 # 300
    CALL_ARGS=
    TRAINER_ARGS="--architecture splade --splade_reg 1e-4 --splade_mask_mode nomath --warmup-epochs 1 --lr 2e-5"
    ;;
   *)
    echo "[Bad args] $COMMAND"
    exit 1;
    ;;
esac
N_NODE=$(cat $0 | grep -Po '(?<=SBATCH --nodes=)[0-9]+')
N_GPUS=$(cat $0 | grep -Po '(?<=SBATCH --gres=gpu:)[0-9]+')
if [ -z "$N_GPUS" ]; then
    N_GPUS=$(cat $0 | grep -Po '(?<=SBATCH --gres=gpu:).+:[0-9]+')
    N_GPUS=$(echo $N_GPUS | cut -f 2 -d':')
fi
if [ -z "$N_GPUS" -o -z "$N_NODE" ]; then
    echo "No value in: num_node=$N_NODE, num_gpu=$N_GPUS"
    exit 1
else
    echo "num_node=$N_NODE, num_gpu=$N_GPUS"
fi
DATA_DIR=data.$DATA_VER
set -e
if [ ! -e $DATA_DIR ]; then
    tarball=`mktemp`
    wget https://vault.cs.uwaterloo.ca/s/$DATA_VER/download -O $tarball
    tar xzf $tarball --one-top-level=$DATA_DIR --strip-components 1
fi
set +e
export NCCL_BLOCKING_WAIT=1  # Set this variable to use the NCCL backend
export NCCL_IB_DISABLE=1
export NCCL_DEBUG=INFO
export NCCL_P2P_DISABLE=1
export SLURM_ACCOUNT=def-jimmylin
export SBATCH_ACCOUNT=$SLURM_ACCOUNT
export SALLOC_ACCOUNT=$SLURM_ACCOUNT
export TORCH_DISTRIBUTED_DEBUG=OFF #DETAIL
lower_port=$(cat /proc/sys/net/ipv4/ip_local_port_range | awk '{print $1}')
upper_port=$(cat /proc/sys/net/ipv4/ip_local_port_range | awk '{print $2}')
set +x
for port in $(seq $lower_port $upper_port); do
    nc -z $(hostname) $port 2>/dev/null || break
done
set -x
echo "Using TCP port ${port} ..."
if which srun; then
    let TOTAL_N="$N_NODE * $N_GPUS"
    srun --unbuffered \
        python ../utils/transformer.py $TRAINER \
        $START_POINT $TOK_CKPOINT $CALL_ARGS \
        --test_file $DATA_DIR/$TEST_FILE --test_cycle $TEST_CYCLE \
        --shards_list $DATA_DIR/$SHARDS_LIST \
        --cluster tcp://$(hostname):${port} \
        --batch_size $(($TOTAL_N * $DEV_BSIZE)) \
        --save_fold $SAVE_FOLD --epochs $EPOCHS \
        --save_prefix $SAVE_PREFIX $TRAINER_ARGS
else
    TOTAL_N=$(echo $DEVICES | awk -F',' '{print NF}')
    export SLURM_JOB_ID=$TRAINER-${SETUP}
    python ../utils/transformer.py $TRAINER \
        $START_POINT $TOK_CKPOINT $CALL_ARGS \
        --test_file $DATA_DIR/$TEST_FILE --test_cycle $TEST_CYCLE \
        --shards_list $DATA_DIR/$SHARDS_LIST \
        --cluster tcp://$(hostname):${port} \
        --batch_size $(($TOTAL_N * $DEV_BSIZE)) \
        --save_fold $SAVE_FOLD --epochs $EPOCHS \
        --save_prefix $SAVE_PREFIX $TRAINER_ARGS \
        --dev_map $DEVICES
fi;
} 2>&1 | tee $SAVE_PREFIX/job-$TRAINER-$SETUP.console.log
