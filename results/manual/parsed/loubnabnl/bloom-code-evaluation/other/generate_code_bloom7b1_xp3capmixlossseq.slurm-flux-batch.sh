#!/bin/bash
#FLUX: --job-name=bs-code-generation-bloom-7b1-xp3capmixlossseq
#FLUX: -c=8
#FLUX: --queue=gpu_p5
#FLUX: -t=72000
#FLUX: --urgency=16

export HF_DATASETS_OFFLINE='1'
export TRANSFORMERS_OFFLINE='1'
export TRANSFORMERS_CACHE='$six_ALL_CCFRWORK/models'
export HF_DATASETS_CACHE='$six_ALL_CCFRWORK/datasets_code_eval'
export HF_MODULES_CACHE='$six_ALL_CCFRWORK/modules'
export HF_METRICS_CACHE='$six_ALL_CCFRWORK/metrics'
export CUDA_LAUNCH_BLOCKING='1'

set -x -e
source $six_ALL_CCFRWORK/start-py38-pt111
conda activate thomas_code_evaluation
echo "START TIME: $(date)"
MODEL_CKPT=/gpfsscratch/rech/six/commun/experiments/muennighoff/bloomckpt/6b3t0/tr13f-6b3-ml-t0-lmtoks341b-t0toks13b-xp3capmixlossseq
export HF_DATASETS_OFFLINE=1
export TRANSFORMERS_OFFLINE=1
export TRANSFORMERS_CACHE=$six_ALL_CCFRWORK/models
export HF_DATASETS_CACHE=$six_ALL_CCFRWORK/datasets_code_eval
export HF_MODULES_CACHE=$six_ALL_CCFRWORK/modules
export HF_METRICS_CACHE=$six_ALL_CCFRWORK/metrics
NUM_TASKS=164
NUM_TASKS_PER_JOB=1
TASK_START=$((($SLURM_ARRAY_TASK_ID) * $NUM_TASKS_PER_JOB))
TASK_END=$(($TASK_START + $NUM_TASKS_PER_JOB))
STORE_GENERATIONS_FOLDER=/gpfswork/rech/six/commun/code_generations_tr13f-6b3-ml-t0-lmtoks341b-t0toks13b-xp3capmixlossseq
OUTPUT_FILE1=$STORE_GENERATIONS_FOLDER/task_${TASK_START}_${TASK_END}/output_1
OUTPUT_FILE2=$STORE_GENERATIONS_FOLDER/task_${TASK_START}_${TASK_END}/output_2
OUTPUT_FILE3=$STORE_GENERATIONS_FOLDER/task_${TASK_START}_${TASK_END}/output_3
echo using $MODEL_CKPT as model checkpoint, if not done change it to a local repository
WORKDIR=/gpfsscratch/rech/six/commun/commun/experiments/muennighoff/bloom-code-evaluation
pushd $WORKDIR
export CUDA_LAUNCH_BLOCKING=1
python code_eval.py --model_ckpt $MODEL_CKPT \
	--batch_size 1 \
	--do_sample True \
	--task_start $TASK_START \
	--task_end $TASK_END \
	--temperature 0.6 \
	--top_p 0.95 \
	--n_samples 200 \
	--dtype float16 \
	--output_file $OUTPUT_FILE2
python code_eval.py --model_ckpt $MODEL_CKPT \
	--batch_size 1 \
	--do_sample True \
	--task_start $TASK_START \
	--task_end $TASK_END \
	--temperature 0.8 \
	--top_p 0.95 \
	--n_samples 200 \
	--dtype float16 \
	--output_file $OUTPUT_FILE3
