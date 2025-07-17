#!/bin/bash
#FLUX: --job-name=sticky-chip-5094
#FLUX: -N=2
#FLUX: --queue=gputest
#FLUX: -t=900
#FLUX: --urgency=16

export SING_FLAGS='$SING_FLAGS -B /appl/spack/install-tree/gcc-4.8.5/pdsh-2.31-cdzt5w/bin:/usr/local/sbin'

DATA_DIR=data
OUTPUT_DIR=output
PER_GPU_BATCH_SIZE=6
NUM_EPOCHS=10
GRADIENT_ACCUMULATION_STEPS=4
BASE_LEARNING_RATE=5e-05
GPUS_PER_NODE=4
set -euo pipefail
module purge
module load gcc/9.1.0 cuda/11.1.0 pytorch/1.9 pdsh/2.31
export SING_FLAGS="$SING_FLAGS -B /appl/spack/install-tree/gcc-4.8.5/pdsh-2.31-cdzt5w/bin:/usr/local/sbin"
echo "Native pdsh      : $(which pdsh)"
echo "Singularity pdsh : $(python -c 'import shutil; print(shutil.which("pdsh"))')"
rm -rf "$OUTPUT_DIR"
rm -f logs/latest.out logs/latest.err
ln -s $SLURM_JOBID.out logs/latest.out
ln -s $SLURM_JOBID.err logs/latest.err
NODELIST=$(scontrol show hostnames "$SLURM_JOB_NODELIST")
NUM_NODES=$(echo "$NODELIST" | wc -l)
MASTER_NODE=$(echo "$NODELIST" | head -n 1)
echo "MASTER_NODE $MASTER_NODE, NUM_NODES $NUM_NODES"
HOSTFILE=hostfiles/$SLURM_JOBID.txt
rm -f hostfiles/latest.txt
ln -s $SLURM_JOBID.txt hostfiles/latest.txt
echo "$NODELIST" | perl -pe 's/$/ slots='"$GPUS_PER_NODE"'/' > "$HOSTFILE"
TRAIN_FILE="$DATA_DIR/train.pickle"
if [ ! -e "$TRAIN_FILE" ]; then
    echo "$TRAIN_FILE: No such file" >&2
    exit 1
fi
echo -n "Counting number of training examples..." >&2
TRAIN_EXAMPLES=$(
    python pickled_stats.py "$TRAIN_FILE" 2>/dev/null |
    egrep 'TOTAL$' | perl -pe 's/.*?(\d+) TOTAL/$1/'
)
echo "done." >&2
TOTAL_TRAIN_EXAMPLES=$((TRAIN_EXAMPLES * NUM_EPOCHS))
NUM_GPUS=$((NUM_NODES*GPUS_PER_NODE))
EFFECTIVE_BATCH_SIZE=$((
	PER_GPU_BATCH_SIZE *
	NUM_GPUS *
	GRADIENT_ACCUMULATION_STEPS
))
MAX_STEPS=$((
	(TOTAL_TRAIN_EXAMPLES + (EFFECTIVE_BATCH_SIZE-1)) /
	EFFECTIVE_BATCH_SIZE
))
LEARNING_RATE=$(python -c 'print('"$BASE_LEARNING_RATE"'*'"$NUM_NODES"'*'"$GRADIENT_ACCUMULATION_STEPS"')')
cat <<EOF
------------------------------------------------------------------------------
TRAIN_EXAMPLES ................ $TRAIN_EXAMPLES
NUM_EPOCHS .................... $NUM_EPOCHS
PER_GPU_BATCH_SIZE ............ $PER_GPU_BATCH_SIZE
NUM_GPUS ...................... $NUM_GPUS
GRADIENT_ACCUMULATION_STEPS ... $GRADIENT_ACCUMULATION_STEPS
EFFECTIVE_BATCH_SIZE .......... $EFFECTIVE_BATCH_SIZE
MAX_STEPS ..................... $MAX_STEPS
LEARNING_RATE ................. $LEARNING_RATE
------------------------------------------------------------------------------
EOF
echo "START $SLURM_JOBID: $(date)"
./deepspeed_singularity.sh \
    --master_addr "$MASTER_NODE" \
    --hostfile "$HOSTFILE" \
    run_clm.py \
    --preprocessed \
    --tokenizer tokenizer \
    --model_type gpt2 \
    --dataset_name "pickled" \
    --data_dir "$DATA_DIR" \
    --do_train \
    --do_eval \
    --max_steps "$MAX_STEPS" \
    --save_strategy "steps" \
    --save_steps 1000 \
    --evaluation_strategy "steps" \
    --eval_steps 1000 \
    --save_total_limit 20 \
    --per_device_train_batch_size "$PER_GPU_BATCH_SIZE" \
    --gradient_accumulation_steps "$GRADIENT_ACCUMULATION_STEPS" \
    --learning_rate "$LEARNING_RATE" \
    --output_dir "$OUTPUT_DIR" \
    --deepspeed ds_config.json
echo "END $SLURM_JOBID: $(date)"
