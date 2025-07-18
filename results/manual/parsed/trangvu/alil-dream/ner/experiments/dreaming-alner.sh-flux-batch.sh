#!/bin/bash
#FLUX: --job-name=alner-transfer
#FLUX: --queue=m3g
#FLUX: -t=432000
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0'
export CUDA_CACHE_PATH='$CACHE_PATH'

ROOT_DIR=`cd ..&&pwd`
DATE=`date '+%Y%m%d-%H%M%S'`
SRC_PATH=$ROOT_DIR
DATA_DIR=$ROOT_DIR'/datadir'
OUT_DIR=$ROOT_DIR/results
module load cuda/9.0
module load python/3.6.2
source $ROOT_DIR/../env/bin/activate
export CUDA_VISIBLE_DEVICES=0
CACHE_PATH=/tmp/nv-$DATE
mkdir $CACHE_PATH
export CUDA_CACHE_PATH=$CACHE_PATH
DATASETS=( conll2002 conll2002 conll2002 )
EXPS=( es de nl )
TRAINS=( es.train de.train nl.train )
TESTS=( es.testa de.testa nl.testa )
DEVS=( es.testb de.testb nl.testb )
STRATEGIES=( Random Uncertainty Diversity )
POLICY_NAMES=( en.bi.policy )
POLICY_PATHS=( conll2003_en.bi/conll2003_policy.ckpt )
index=$1
policy_idx=$2
DATASET_NAME=${DATASETS[$index]}
EXP_NAME=${EXPS[$index]}
TRAIN_FILE=${TRAINS[$index]}
DEV_FILE=${DEVS[$index]}
TESTS_FILE=${TESTS[$index]}
EMBEDING_FILE=$DATA_DIR/"twelve.table4.multiCCA.window_5+iter_10+size_40+threads_16.normalized"
POLICY_PATH=$ROOT_DIR/policy/${POLICY_PATHS[$policy_idx]}
POLICY_NAME=${POLICY_NAMES[$policy_idx]}
TEXT_DATA_DIR=$DATA_DIR'/'$DATASET_NAME
OUTPUT=$OUT_DIR/dreaming_${DATASET_NAME}_${EXP_NAME}_${DATE}
mkdir -p $OUTPUT
echo "DREAM TRANSFER AL POLICY ${POLICY_NAME} with policy path ${POLICY_PATH} on dataset ${DATASET_NAME} experiment name ${EXP_NAME} "
cd $SRC_PATH && python AL-crf-dreaming.py --root_dir $ROOT_DIR --dataset_name $DATASET_NAME  \
    --train_file $TEXT_DATA_DIR/$TRAIN_FILE --dev_file $TEXT_DATA_DIR/$DEV_FILE \
    --test_file $TEXT_DATA_DIR/$TESTS_FILE \
    --policy_path $POLICY_PATH\
    --word_vec_file $EMBEDING_FILE --episodes 1 --timesteps 20 \
    --output $OUTPUT --label_data_size 100 --annotation_budget 200 \
    --initial_training_size 0 --learning_phase_length 5 --vocab_size 20000 \
    --ndream 5 --dreaming_budget 10 --al_candidate_selection_mode uncertainty
rm -r -f $CACHE_PATH
