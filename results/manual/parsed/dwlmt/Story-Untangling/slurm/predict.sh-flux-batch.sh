#!/bin/bash
#FLUX: --job-name=blue-carrot-0059
#FLUX: -c=4
#FLUX: --urgency=16

export STUDENT_ID='${USER}'
export NLTK_DATA='${CLUSTER_HOME}/nltk_data/'
export EXP_ROOT='${CLUSTER_HOME}/git/Story-Untangling/'
export ALLENNLP_CACHE_ROOT='${CLUSTER_HOME}/allennlp_cache_root/'
export SERIAL_DIR='${SCRATCH_HOME}/${EXP_NAME}'
export DATASET_PATH='/home/s1569885/comics/stories/WritingPrompts/dataset_db/text/'
export PREDICTION_STORY_ID_FILE='/home/s1569885/comics/stories/WritingPrompts/annotation_results/raw/story_id_test_1.csv'
export PREDICTION_ONLY_ANNOTATION_STORIES='TRUE'
export PREDICTION_LEVELS_TO_ROLLOUT='1'
export PREDICTION_GENERATE_PER_BRANCH='100'
export PREDICTION_SAMPLE_PER_BRANCH='100'
export PREDICTION_BEAM_SIZE='5'
export PREDICTION_SAMPLE_TOP_K_WORDS='50'
export PREDICTION_WINDOWING='TRUE'
export PREDICTION_SENTIMENT_WEIGHTING='1.0'
export PREDICTION_SENTIMENT_POSITIVE_WEIGHTING='1.0'
export PREDICTION_SENTIMENT_NEGATIVE_WEIGHTING='2.0'
export PREDICTION_MARKED_SENTENCE='FALSE'

set -e # fail fast
source /home/${USER}/miniconda3/bin/activate pytorch
echo "I'm running on ${SLURM_JOB_NODELIST}"
dt=$(date '+%d_%m_%y__%H_%M');
echo ${dt}
export STUDENT_ID=${USER}
declare -a ScratchPathArray=(/disk/scratch/${STUDENT_ID} /disk/scratch_big/${STUDENT_ID} /disk/scratch1/${STUDENT_ID} /disk/scratch2/${STUDENT_ID} /disk/scratch_fast/${STUDENT_ID} ${CLUSTER_HOME}/scratch/${STUDENT_ID})
for i in "${ScratchPathArray[@]}"
do
    echo ${i}
    mkdir -p ${i}
    if [ -w ${i} ];then
      echo "WRITABLE"
      export SCRATCH_HOME=${i}
      break
   fi
done
echo ${SCRATCH_HOME}
export NLTK_DATA="${CLUSTER_HOME}/nltk_data/"
export EXP_ROOT="${CLUSTER_HOME}/git/Story-Untangling/"
export ALLENNLP_CACHE_ROOT="${CLUSTER_HOME}/allennlp_cache_root/"
export SERIAL_DIR="${SCRATCH_HOME}/${EXP_NAME}"
export DATASET_PATH="/home/s1569885/comics/stories/WritingPrompts/dataset_db/text/"
export PREDICTION_STORY_ID_FILE="/home/s1569885/comics/stories/WritingPrompts/annotation_results/raw/story_id_test_1.csv"
export PREDICTION_ONLY_ANNOTATION_STORIES=TRUE
export PREDICTION_LEVELS_TO_ROLLOUT=1
export PREDICTION_GENERATE_PER_BRANCH=100
export PREDICTION_SAMPLE_PER_BRANCH=100
export PREDICTION_BEAM_SIZE=5
export PREDICTION_SAMPLE_TOP_K_WORDS=50
export PREDICTION_WINDOWING=TRUE
export PREDICTION_SENTIMENT_WEIGHTING=1.0
export PREDICTION_SENTIMENT_POSITIVE_WEIGHTING=1.0
export PREDICTION_SENTIMENT_NEGATIVE_WEIGHTING=2.0
export PREDICTION_MARKED_SENTENCE=FALSE
cd "${EXP_ROOT}" # helps AllenNLP behave
mkdir -p ${SERIAL_DIR}
echo "ALLENNLP Task========"
allennlp predict --include-package story_untangling \
    --use-dataset-reader \
    --predictor uncertain_reader_gen_predictor \
     ${CLUSTER_HOME}/comics/stories/WritingPrompts/training_models/full_epoch/lstm_fusion_big/ \
     ${CLUSTER_HOME}/comics/stories/WritingPrompts/datasets/test.wp_target --cuda-device 0 \
    --output-file  ${SERIAL_DIR}/${EXP_NAME}_prediction_output.jsonl \
echo "============"
echo "ALLENNLP Task finished"
mkdir -p "${CLUSTER_HOME}/runs/cluster/"
rsync -avuzhP "${SERIAL_DIR}" "${CLUSTER_HOME}/runs/cluster/" # Copy output onto headnode
rm -rf "${SERIAL_DIR}/"
echo "============"
echo "results synced"
