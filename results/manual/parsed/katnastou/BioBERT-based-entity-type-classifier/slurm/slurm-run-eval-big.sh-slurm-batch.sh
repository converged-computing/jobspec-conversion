#!/bin/bash
#FLUX: --job-name=12.5M
#FLUX: -n=4
#FLUX: -c=10
#FLUX: --queue=gputest
#FLUX: -t=900
#FLUX: --urgency=16

export PATH='${HOME}/openmpi/bin:$PATH'
export LD_LIBRARY_PATH='${HOME}/openmpi/lib:$LD_LIBRARY_PATH'
export NCCL_DEBUG='INFO'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export NCCL_P2P_DISABLE='1'

module purge
source venv/bin/activate
export PATH=${HOME}/openmpi/bin:$PATH
export LD_LIBRARY_PATH=${HOME}/openmpi/lib:$LD_LIBRARY_PATH
OUTPUT_DIR="output-biobert/multigpu/$SLURM_JOBID"
mkdir -p $OUTPUT_DIR
function on_exit {
   rm -rf "$OUTPUT_DIR"
   rm -f jobs/$SLURM_JOBID
}
trap on_exit EXIT
if [ "$#" -ne 7 ]; then
    echo "Usage: $0 model_dir data_dir max_seq_len batch_size task init_checkpoint labels_dir"
    exit 1
fi
BERT_DIR="$1"
DATASET_DIR="$2"
MAX_SEQ_LENGTH="$3"
BATCH_SIZE="$4"
TASK="$5"
INIT_CKPT="$6"
LABELS_DIR="$7"
cased="true"
if [ "$cased" = "true" ] ; then
    DO_LOWER_CASE=0
    CASING_DIR_PREFIX="cased"
    case_flag="--do_lower_case=False"
else
    DO_LOWER_CASE=1
    CASING_DIR_PREFIX="uncased"
    case_flag="--do_lower_case=True"
fi
export NCCL_DEBUG=INFO
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export NCCL_P2P_DISABLE=1
echo "START $SLURM_JOBID: $(date)"
python3 run_ner_consensus.py \
    --do_prepare=true \
    --do_train=false \
    --do_eval=true \
    --do_predict=false \
    --replace_span="[unused1]" \
    --task_name=$TASK \
    --init_checkpoint=$INIT_CKPT \
    --vocab_file=$BERT_DIR/vocab.txt \
    --bert_config_file=$BERT_DIR/bert_config.json \
    --data_dir=$DATASET_DIR \
    --output_dir=$OUTPUT_DIR \
    --eval_batch_size=$BATCH_SIZE \
    --predict_batch_size=$BATCH_SIZE \
    --max_seq_length=$MAX_SEQ_LENGTH \
    --cased=$cased \
    --labels_dir=$LABELS_DIR \
    --use_xla \
    --use_fp16 \
    --horovod
result=$(egrep '^INFO:tensorflow:  eval_accuracy' logs/${SLURM_JOB_ID}.err | perl -pe 's/.*accuracy \= (\d)\.(\d{2})(\d{2})\d+$/$2\.$3/')
echo -n 'TEST-RESULT'$'\t'
echo -n 'init_checkpoint'$'\t'"$INIT_CKPT"$'\t'
echo -n 'data_dir'$'\t'"$DATASET_DIR"$'\t'
echo -n 'max_seq_length'$'\t'"$MAX_SEQ_LENGTH"$'\t'
echo -n 'accuracy'$'\t'"$result"$'\n'
seff $SLURM_JOBID
