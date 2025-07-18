#!/bin/bash
#FLUX: --job-name=outstanding-ricecake-0026
#FLUX: -t=172800
#FLUX: --urgency=16

export PYTHONPATH='/home/zp489/miniconda3/envs/bert/lib/python3.6/site-packages:$PYTHONPATH'

module load tensorflow/python3.6/1.5.0
source activate bert
export PYTHONPATH=/home/zp489/miniconda3/envs/bert/lib/python3.6/site-packages:$PYTHONPATH
source $BERT_RUN_CONFIG
echo $SLURM_JOBID - $BERT_RUN_CONFIG - `hostname` >> ~/bert_machine_assignments.txt
echo Using: [$BERT_MODEL_INIT_PATH]
python ../pytorch-pretrained-BERT/run_classifier.py \
  --task_name $BERT_TASK_NAME \
  --do_train \
  --do_eval \
  --do_lower_case \
  --data_dir $GLUE_DIR/$BERT_FOL_NAME/ \
  --vocab_file $BERT_PYTORCH_DIR/vocab.txt \
  --bert_config_file $BERT_PYTORCH_DIR/bert_config.json \
  --init_checkpoint $BERT_PYTORCH_MODEL_INIT_PATH \
  --max_seq_length 128 \
  --train_batch_size $BERT_BATCH_SIZE \
  --learning_rate 2e-5 \
  --num_train_epochs 3.0 \
  --seed=${BERT_SEED:-1} \
  --output_dir $BERT_OUTPUT_DIR
echo DONE
