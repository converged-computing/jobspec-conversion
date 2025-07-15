#!/bin/bash
#FLUX: --job-name=adorable-fudge-0855
#FLUX: --urgency=16

export FASTBPE='../../fastBPE/fastBPE'
export MOSES='../../mosesdecoder'

MODEL_DIR=../../checkpoints/RE-BC5CDR-BioGPT-v2
MODEL=checkpoint_best.pt
DATA_DIR=${PWD}/../../data/BC5CDR/relis-bin
BASE_DATA_DIR=${DATA_DIR%/*}
BIN_DATA_DIR=${DATA_DIR##*/}
DATA_PREFIX=${BIN_DATA_DIR%-*}
RAW_DATA_DIR=${BASE_DATA_DIR}/raw
INPUT_FILE=$1
OUTPUT_FILE=$2
OUTPUT_FILE_NAME=$(basename ${OUTPUT_FILE} .txt)
TEMP_DIR=../../interactive/temp
ENTITY_FILE=${RAW_DATA_DIR}/train.entities.json
PMID_FILE=${RAW_DATA_DIR}/${DATA_PREFIX}_train.pmid
export FASTBPE=../../fastBPE/fastBPE
export MOSES=../../mosesdecoder
ml Anaconda/2021.05-nsc1
conda activate /proj/berzelius-2021-21/users/jacob/conda_envs/biogpt
echo $OUTPUT_FILE_NAME
echo "*** PRE-PROCESSING  ***"
if [ -d "${TEMP_DIR}" ]; then
    rm ${TEMP_DIR}/*
fi
echo "*** TOKENIZATION ***"
echo $INPUT_FILE
echo $OUTPUT_FILE
perl ${MOSES}/scripts/tokenizer/tokenizer.perl -l en -a -threads 8 < ${INPUT_FILE} > ${TEMP_DIR}/${OUTPUT_FILE_NAME}.tok.x
echo "*** FAST BPE ***"
${FASTBPE}/fast applybpe ${TEMP_DIR}/${OUTPUT_FILE_NAME}.tok.bpe.x  ${TEMP_DIR}/${OUTPUT_FILE_NAME}.tok.x ${RAW_DATA_DIR}/bpecodes
echo "*** BINARIZE ***"
fairseq-preprocess \
    -s x --workers 8 \
    --only-source \
    --validpref ${TEMP_DIR}/${OUTPUT_FILE_NAME}.tok.bpe \
    --destdir ${TEMP_DIR} \
    --srcdict ${RAW_DATA_DIR}/dict.txt
echo "*** INFERENCE ***"
echo ${TEMP_DIR}/${OUTPUT_FILE_NAME}.txt
echo "Begin inferencing ${INPUT_FILE} using ${MODEL_DIR}/${MODEL}"
python ../../inference.py --data_dir=${DATA_DIR} --model_dir=${MODEL_DIR} --model_file=${MODEL} --src_file=${INPUT_FILE} --output_file=${TEMP_DIR}/${OUTPUT_FILE_NAME}.txt
echo "*** DEBPE ***"
sed -i "s/@@ //g" ${TEMP_DIR}/${OUTPUT_FILE_NAME}.txt
echo "*** DETOKENIZATION ***"
perl ${MOSES}/scripts/tokenizer/detokenizer.perl -l en -a < ${TEMP_DIR}/${OUTPUT_FILE_NAME}.txt > ${TEMP_DIR}/${OUTPUT_FILE_NAME}.detok
echo "*** POST PROCESS ***"
python postprocess.py ${TEMP_DIR}/${OUTPUT_FILE_NAME}.detok ${ENTITY_FILE} ${PMID_FILE}
mv ${TEMP_DIR}/${OUTPUT_FILE_NAME}.detok.extracted.PubTator ${OUTPUT_FILE}
