#!/bin/bash
#FLUX: --job-name=alil-policy
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
module load tensorflow/1.12.0-python3.6-gcc5
export CUDA_VISIBLE_DEVICES=0
CACHE_PATH=/tmp/nv-$DATE
mkdir $CACHE_PATH
export CUDA_CACHE_PATH=$CACHE_PATH
DATASETS=( elec_music book_movie ap17)
EXPS=( source source en)
DIMS=( 100 100 40 )
index=$1
DATASET_NAME=${DATASETS[$index]}
EXP_NAME=${EXPS[$index]}
EMBEDING_FILE="${DATASET_NAME}_w2v.txt"
TEXT_DATA_DIR=$DATA_DIR'/'$DATASET_NAME'/'$EXP_NAME
EMB_DIM=${DIMS[$index]}
OUTPUT=$OUT_DIR/classifier_${DATASET_NAME}_${EXP_NAME}_${DATE}
mkdir -p $OUTPUT
echo "TRAIN classifier on dataset ${DATASET_NAME} experiment name ${EXP_NAME} "
cd $SRC_PATH && python train-classifier.py --root_dir $ROOT_DIR --dataset_name $DATASET_NAME --text_data_dir $TEXT_DATA_DIR \
    --word_vec_dir $DATA_DIR/word_vec/$EMBEDING_FILE \
    --output $OUTPUT --embedding_dim $EMB_DIM
rm -r -f $CACHE_PATH
