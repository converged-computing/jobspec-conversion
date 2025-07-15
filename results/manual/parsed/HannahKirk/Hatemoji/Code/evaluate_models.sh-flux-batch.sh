#!/bin/bash
#FLUX: --job-name=hatemoji_eval
#FLUX: --priority=16

module load cuda/10.1
module load python/anaconda3
source activate hatemoji
USER_PATH = #`enter path to code directory e.g. ./Hatemoji/Code`
ROUND_ID = #`enter current round e.g. r5,r6,r7`
BEST_UPSAMPLE = #`enter best upsampling ratio for round e.g.upsample1 or upsample100`
BEST_MODEL = # `enter best model for round from ['deberta'/'bertweet']`
DATA_DIR=`cat $USER_PATH/eval_step/jobs/$SLURM_ARRAY_TASK_ID`
echo $DATA_DIR
mkdir -p $USER_PATH/eval_step/$ROUND_ID/$DATA_DIR/
echo "NODELIST HERE"
echo $SLURM_JOB_NODELIST
echo $SLURMD_NODENAME
HF_DATASETS_OFFLINE=1 TRANSFORMERS_OFFLINE=1 \
python $USER_PATH/run_glue_eval.py \
--model_name_or_path $USER_PATH/train_step/$ROUND_ID/$BEST_UPSAMPLE/$BEST_MODEL \
--train_file $USER_PATH/eval_step/shared_test_sets/$DATA_DIR/test.csv \
--validation_file $USER_PATH/eval_step/shared_test_sets/$DATA_DIR/test.csv \
--test_file $USER_PATH/eval_step/shared_test_sets/$DATA_DIR/test.csv \
--do_eval \
--do_predict \
--output_dir $USER_PATH/eval_step/$ROUND_ID/$DATA_DIR/ \
--seed 123 \
--cache_dir $USER_PATH/.cache/huggingface/transformers/ \
--overwrite_output_dir > $USER_PATH/eval_step/$ROUND_ID/$DATA_DIR/log_test 2> $USER_PATH/eval_step/$ROUND_ID/$DATA_DIR/err_test
