#!/bin/bash
#FLUX: --job-name=utility_aus_fullmodel_80K
#FLUX: --queue=gpu
#FLUX: --priority=16

export PATH='/fs/clip-amr/anaconda2/bin:$PATH'

SITENAME=askubuntu_unix_superuser
DATA_DIR=/fs/clip-corpora/amazon_qa
UTILITY_DATA_DIR=/fs/clip-scratch/raosudha/clarification_question_generation/utility/$SITENAME
SCRIPT_DIR=/fs/clip-amr/clarification_question_generation_pytorch/src/utility
EMB_DIR=/fs/clip-amr/clarification_question_generation_pytorch/embeddings/$SITENAME/200_5Kvocab
source /fs/clip-amr/gpu_virtualenv/bin/activate
export PATH="/fs/clip-amr/anaconda2/bin:$PATH"
python $SCRIPT_DIR/rnn_classifier.py	--train_data $UTILITY_DATA_DIR/train_data.p \
										--tune_data $UTILITY_DATA_DIR/tune_data.p \
										--test_data $UTILITY_DATA_DIR/test_data.p \
										--word_embeddings $EMB_DIR/word_embeddings.p \
										--vocab $EMB_DIR/vocab.p \
										--cuda True \
