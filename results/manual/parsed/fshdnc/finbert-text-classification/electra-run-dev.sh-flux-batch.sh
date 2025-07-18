#!/bin/bash
#FLUX: --job-name=cowy-carrot-7627
#FLUX: --queue=gputest
#FLUX: -t=900
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

OUTPUT_DIR="output-electra/$SLURM_JOBID"
function on_exit {
    #rm -rf "$OUTPUT_DIR"
    rm -f jobs/$SLURM_JOBID
    seff $SLURM_JOBID
    gpuseff $SLURM_JOBID
    echo "END $SLURM_JOBID: $(date)"
}
trap on_exit EXIT
if [ "$#" -ne 6 ]; then
    echo "Usage: $0 model_name data_dir seq_len batch_size learning_rate epochs"
    exit 1
fi
MODEL_NAME="$1"
DATA_DIR="$2"
MAX_SEQ_LENGTH="$3"
BATCH_SIZE="$4"
LEARNING_RATE="$5"
EPOCHS="$6"
cd /scratch/project_2002820/lihsin/finbert-text-classification
source /scratch/project_2002820/lihsin/bert-experiments/scripts/select-model.sh
return_model $MODEL_NAME
VOCAB="$MODELDIR/vocab.txt"
CONFIG="$MODELDIR/bert_config.json"
if [[ $MODEL =~ "uncased" ]]; then
    lower_case="true"
elif [[ $MODEL =~ "multilingual" ]]; then
    lower_case="true"
else
    lower_case="false"
fi
if [[ $DATA_DIR =~ "ylilauta" ]]; then
    task_name="ylilauta"
elif [[ $DATA_DIR =~ "yle" ]]; then
    task_name="yle"
else
    echo "Error: can't determine task from data dir $DATA_DIR"
    exit 1
fi
module purge
module load tensorflow
source /projappl/project_2002820/venv/bert-pos/bin/activate
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
echo "START $SLURM_JOBID: $(date)"
BATCH_SIZE=16
python3 run_classifier.py \
    --task_name "$task_name" \
    --do_train=true \
    --do_eval=true \
    --bert_config_file "$CONFIG" \
    --init_checkpoint "$MODELDIR/$MODEL" \
    --vocab_file "$VOCAB" \
    --do_lower_case="$lower_case" \
    --learning_rate $LEARNING_RATE \
    --max_seq_length $MAX_SEQ_LENGTH \
    --train_batch_size $BATCH_SIZE \
    --num_train_epochs $EPOCHS \
    --data_dir "$DATA_DIR" \
    --output_dir "$OUTPUT_DIR"
on_exit
