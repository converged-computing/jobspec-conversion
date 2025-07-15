#!/bin/bash
#FLUX: --job-name=astute-pastry-8378
#FLUX: -c=6
#FLUX: --urgency=16

export PATH='${HOME}/openmpi/bin:$PATH'
export LD_LIBRARY_PATH='${HOME}/openmpi/lib:$LD_LIBRARY_PATH'
export NCCL_DEBUG='INFO'

module purge
source venv/bin/activate
export PATH=${HOME}/openmpi/bin:$PATH
export LD_LIBRARY_PATH=${HOME}/openmpi/lib:$LD_LIBRARY_PATH
OUTPUT_DIR="output-biobert/multigpu/$SLURM_JOBID"
mkdir -p $OUTPUT_DIR
if [ "$#" -ne 9 ]; then
    echo "Usage: $0 model_dir data_dir max_seq_len batch_size task init_checkpoint labels_dir predictions_dir job_dir"
    exit 1
fi
BERT_DIR="$1"
DATASET_DIR="$2"
MAX_SEQ_LEN="$3"
BATCH_SIZE="$4"
TASK="$5"
INIT_CKPT="$6"
LABELS_DIR="$7"
PRED_DIR="$8" 
JOB_DIR="$9"
JOB_FILE=${JOB_DIR}/${SLURM_JOBID}
function on_exit {
   rm -rf ${JOB_FILE}
}
trap on_exit EXIT
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
echo "START $SLURM_JOBID: $(date)"
python3 run_ner_consensus.py \
    --do_prepare=true \
    --do_train=false \
    --do_eval=true \
    --do_predict=true \
    --replace_span="[unused1]" \
    --task_name=$TASK \
    --init_checkpoint=$INIT_CKPT \
    --vocab_file=$BERT_DIR/vocab.txt \
    --bert_config_file=$BERT_DIR/bert_config.json \
    --data_dir=$DATASET_DIR \
    --output_dir=$OUTPUT_DIR \
    --eval_batch_size=$BATCH_SIZE \
    --predict_batch_size=$BATCH_SIZE \
    --max_seq_length=$MAX_SEQ_LEN \
    --use_fp16 \
    --use_xla \
    --horovod \
    --cased=$cased \
    --labels_dir=$LABELS_DIR
result=$(egrep '^INFO:tensorflow:  eval_accuracy' logs/${SLURM_JOB_ID}.err | perl -pe 's/.*accuracy \= (\d)\.(\d{2})(\d{2})\d+$/$2\.$3/')
echo -n 'TEST-RESULT'$'\t'
echo -n 'init_checkpoint'$'\t'"$INIT_CKPT"$'\t'
echo -n 'data_dir'$'\t'"$DATASET_DIR"$'\t'
echo -n 'max_seq_length'$'\t'"$MAX_SEQ_LENGTH"$'\t'
echo -n 'accuracy'$'\t'"$result"$'\n'
paste <(paste ${DATASET_DIR}"/test.tsv" ${OUTPUT_DIR}"/test_output_labels.txt") ${OUTPUT_DIR}"/test_results.tsv" | awk -F'\t' '{printf("%s\t%s\t%s\t%s\t%s\t%s\t%s\t\'\{\''che'\'': %s'\,' '\''dis'\'': %s'\,' '\''ggp'\'': %s'\,' '\''org'\'': %s'\,' '\''out'\'': %s'\}'\n",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)}' > ${OUTPUT_DIR}"/output_with_probabilities_dict.tsv"; 
mkdir -p $PRED_DIR
cp ${OUTPUT_DIR}"/output_with_probabilities_dict.tsv" ${PRED_DIR}"/output_with_probabilities_"$(basename ${DATASET_DIR##*-})".tsv"
echo -n 'result written in '"$PRED_DIR"$'\n'
seff $SLURM_JOBID
