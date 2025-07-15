#!/bin/bash
#FLUX: --job-name=clean_data
#FLUX: --queue=standard
#FLUX: -t=36000
#FLUX: --priority=16

DATA_FILE=../../data/reddit_data/subreddit_submissions_2018-01_2019-12.gz
COMMENT_DATA=../../data/reddit_data/advice_subreddit_filter_comment_question_data.gz
DATA_NAME=combined_data_full
OUT_DIR=/scratch/mihalcea_root/mihalcea0/ianbstew/
AUTHOR_DATA=../../data/reddit_data/author_data/combined_author_prior_comment_data.gz # contains static and dynamic author data
MODEL_TYPE=bart
SAMPLE_PCT=1.0
HF_DATASETS_OFFLINE=1 TRANSFORMERS_OFFLINE=1 \
python clean_data_for_generation.py $OUT_DIR --data_file $DATA_FILE --data_name $DATA_NAME --model_type $MODEL_TYPE --comment_data $COMMENT_DATA --author_data $AUTHOR_DATA --sample_pct $SAMPLE_PCT
