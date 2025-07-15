#!/bin/bash
#FLUX: --job-name=creamy-platanos-1024
#FLUX: -t=172800
#FLUX: --priority=16

export PYTHONPATH='/home/zp489/miniconda3/envs/bert/lib/python3.6/site-packages:$PYTHONPATH'

module load tensorflow/python3.6/1.5.0
source activate bert
export PYTHONPATH=/home/zp489/miniconda3/envs/bert/lib/python3.6/site-packages:$PYTHONPATH
source $BERT_RUN_CONFIG
echo $SLURM_JOBID - $BERT_RUN_CONFIG - `hostname` >> ~/bert_machine_assignments.txt
echo Using: [$BERT_MODEL_INIT_PATH, $BERT_OUTPUT_DIR, $BERT_DIR, $BERT_MODEL_INIT_PATH]
python run_classifier.py \
  --task_name $BERT_TASK_NAME \
  --do_train \
  --do_eval \
  --do_predict=true \
  --do_lower_case \
  --data_dir $GLUE_DIR/$BERT_FOL_NAME/ \
  --vocab_file $BERT_DIR/vocab.txt \
  --bert_config_file $BERT_DIR/bert_config.json \
  --init_checkpoint $BERT_MODEL_INIT_PATH \
  --max_seq_length 128 \
  --train_batch_size $BERT_BATCH_SIZE \
  --learning_rate 2e-5 \
  --num_train_epochs 3.0 \
  --seed=${BERT_SEED:-1} \
  --output_dir $BERT_OUTPUT_DIR
echo DONE
