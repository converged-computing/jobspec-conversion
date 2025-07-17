#!/bin/bash
#FLUX: --job-name=BERT_TFR
#FLUX: -n=8
#FLUX: -t=54000
#FLUX: --urgency=16

export MAX_PR='20 # max predictions per sequence'
export MAX_SEQ_LEN='128 # max sequence length (128 for the 1st phase, 512 for the 2nd phase)'
export BERT_ROOT='$EBROOTNLPLMINNVIDIA_BERT'
export LOCAL_ROOT='`pwd`'
export OUTPUT_DIR='$LOCAL_ROOT/data/norbert${MAX_SEQ_LEN}/'

umask 0007
module use -a /cluster/projects/nn9851k/software/easybuild/install/modules/all/
module purge   # Recommended for reproducibility
module load NLPL-nvidia_BERT/20.06.8-gomkl-2019b-TensorFlow-1.15.2-Python-3.7.4
export MAX_PR=20 # max predictions per sequence
export MAX_SEQ_LEN=128 # max sequence length (128 for the 1st phase, 512 for the 2nd phase)
export BERT_ROOT=$EBROOTNLPLMINNVIDIA_BERT
export LOCAL_ROOT=`pwd`
export OUTPUT_DIR=$LOCAL_ROOT/data/norbert${MAX_SEQ_LEN}/
mkdir -p $OUTPUT_DIR
echo ${1}  # input corpus
echo ${2}  # wordpiece vocabulary file
echo ${3}  # name(s) of the output TFR file(s), for example, "norbert.tfr"
python3 ${BERT_ROOT}/utils/create_pretraining_data.py --input_file=${1} --vocab_file=${2} --dupe_factor=10 --max_seq_length=${MAX_SEQ_LEN} --max_predictions_per_seq=${MAX_PR} --output_file=${OUTPUT_DIR}${3}
