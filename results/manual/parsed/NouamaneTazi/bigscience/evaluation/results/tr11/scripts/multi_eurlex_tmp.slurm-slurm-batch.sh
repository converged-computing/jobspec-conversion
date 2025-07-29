#!/bin/bash
#FLUX: --job-name=multieurlex
#FLUX: -c=8
#FLUX: -t=72000
#FLUX: --urgency=16

export TRANSFORMERS_CACHE='$six_ALL_CCFRWORK/models'
export HF_DATASETS_CACHE='$six_ALL_CCFRWORK/datasets'
export HF_MODULES_CACHE='$six_ALL_CCFRWORK/modules'
export HF_METRICS_CACHE='$six_ALL_CCFRWORK/metrics'
export HF_DATASETS_OFFLINE='1'
export TRANSFORMERS_OFFLINE='1'
export TOKENIZERS_PARALLELISM='false'

set -x -e
source $six_ALL_CCFRWORK/start-tr13f-6B3-ml-t0
conda activate muennighofflmevalgen
echo "START TIME: $(date)"
export TRANSFORMERS_CACHE=$six_ALL_CCFRWORK/models
export HF_DATASETS_CACHE=$six_ALL_CCFRWORK/datasets
export HF_MODULES_CACHE=$six_ALL_CCFRWORK/modules
export HF_METRICS_CACHE=$six_ALL_CCFRWORK/metrics
export HF_DATASETS_OFFLINE=1
export TRANSFORMERS_OFFLINE=1
export TOKENIZERS_PARALLELISM=false
MODEL_CKPT=/gpfsscratch/rech/six/commun/experiments/muennighoff/bloomckpt/6b3t0/tr13f-6b3-ml-t0-lmtoks341b-t0toks13b-xp3capmixv2lossseq
cd /gpfsscratch/rech/six/commun/experiments/muennighoff/bslmevalgeneration/lm-evaluation-harness
DATASETS_AND_CONFIGS=(
multi_eurlex_mt,multi,"version-fr-en-source+target"
multi_eurlex_mt,multi,"version-en-fr-source+target"
multi_eurlex_mt,multi,"a_good_translation-fr-en-source+target"
multi_eurlex_mt,multi,"a_good_translation-en-fr-source+target"
multi_eurlex_mt,multi,"prev_doc-en-fr"
multi_eurlex_mt,multi,"prev_doc-fr-en"
)
DATASET_AND_CONFIG=${DATASETS_AND_CONFIGS[$SLURM_ARRAY_TASK_ID]}
echo $ARGUMENT
IFS=',' read dataset_name lang template_name <<< "${DATASET_AND_CONFIG}"
python main.py \
    --model_api_name 'hf-causal' \
    --model_args pretrained=$MODEL_CKPT,use_accelerate=True,tokenizer=$MODEL_CKPT,dtype=float16 \
    --device cuda \
    --batch_size 16 \
    --no_tracking \
    --task_name $dataset_name \
    --template_names $template_name \
    --bootstrap_iters 10 \
    --num_fewshot 0 \
    --limit 500
echo "END TIME: $(date)"
