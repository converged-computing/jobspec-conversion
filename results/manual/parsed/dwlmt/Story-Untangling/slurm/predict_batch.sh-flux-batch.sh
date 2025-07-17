#!/bin/bash
#FLUX: --job-name=bumfuzzled-leopard-9006
#FLUX: -c=4
#FLUX: --urgency=16

export STUDENT_ID='${USER}'
export CLUSTER_HOME='/home/${STUDENT_ID}'
export NLTK_DATA='${CLUSTER_HOME}/nltk_data/'
export EXP_ROOT='${CLUSTER_HOME}/git/Story-Untangling/'
export ALLENNLP_CACHE_ROOT='${CLUSTER_HOME}/allennlp_cache_root/'
export LINE='`sed "${SLURM_ARRAY_TASK_ID}q;d" ${BATCH_FILE_PATH}/${BATCH_FILE_NAME}`'
export EXP_NAME='${EXP_BASE_NAME}_${LINE}'
export SERIAL_DIR='${SCRATCH_HOME}/${EXP_NAME}'
export DATASET_PATH='${CLUSTER_HOME}/comics/stories/WritingPrompts/dataset_db/text/'
export PREDICTION_STORY_ID_FILE='${BATCH_FILE_PATH}/${LINE}'
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
export MODEL_PATH='comics/stories/WritingPrompts/training_models/full_epoch/lstm_fusion_big/'
export DATASET_SOURCE='/comics/stories/WritingPrompts/datasets/test.wp_target'

set -e # fail fast
source /home/${USER}/miniconda3/bin/activate pytorch
echo "I'm running on ${SLURM_JOB_NODELIST}"
dt=$(date '+%d_%m_%y__%H_%M');
echo ${dt}
export STUDENT_ID=${USER}
export CLUSTER_HOME="/home/${STUDENT_ID}"
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
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
export LINE=`sed "${SLURM_ARRAY_TASK_ID}q;d" ${BATCH_FILE_PATH}/${BATCH_FILE_NAME}`
export EXP_NAME="${EXP_BASE_NAME}_${LINE}"
export SERIAL_DIR="${SCRATCH_HOME}/${EXP_NAME}"
export DATASET_PATH="${CLUSTER_HOME}/comics/stories/WritingPrompts/dataset_db/text/"
export PREDICTION_STORY_ID_FILE="${BATCH_FILE_PATH}/${LINE}"
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
export MODEL_PATH=comics/stories/WritingPrompts/training_models/full_epoch/lstm_fusion_big/
export DATASET_SOURCE=/comics/stories/WritingPrompts/datasets/test.wp_target
cd "${EXP_ROOT}" # helps AllenNLP behave
rm -rf "${SERIAL_DIR}"
mkdir -p ${SERIAL_DIR}
echo "ALLENNLP Task========"
allennlp predict --include-package story_untangling \
    --use-dataset-reader \
    --predictor uncertain_reader_gen_predictor \
     ${CLUSTER_HOME}/${MODEL_PATH} \
     ${CLUSTER_HOME}/${DATASET_SOURCE} --cuda-device 0 \
    --output-file  ${SERIAL_DIR}/${EXP_NAME}_prediction_output.jsonl \
echo "============"
echo "ALLENNLP Task finished"
mkdir -p "${CLUSTER_HOME}/runs/cluster/"
rsync -avuzhP "${SERIAL_DIR}" "${CLUSTER_HOME}/runs/cluster/" # Copy output onto headnode
rm -rf "${SERIAL_DIR}/"
echo "============"
echo "results synced"
