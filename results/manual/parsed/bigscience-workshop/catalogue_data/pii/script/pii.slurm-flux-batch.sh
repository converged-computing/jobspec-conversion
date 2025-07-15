#!/bin/bash
#FLUX: --job-name=run_pii
#FLUX: -c=40
#FLUX: --queue=cpu_p1
#FLUX: -t=72000
#FLUX: --urgency=16

export HF_DATASETS_OFFLINE='1'
export HF_DATASETS_CACHE='$SCRATCH/to_delete'

set -x -e
source $six_ALL_CCFRWORK/start-prod
DATASET_ID=$SLURM_ARRAY_TASK_ID
LIST_DATASET=("lm_indic-bn_oscar.jsonl" "lm_pt_oscar.jsonl" "lm_indic-ur_oscar.jsonl" "lm_zhs_oscar.jsonl" "lm_indic-hi_oscar.jsonl" "lm_ar_oscar.jsonl" "lm_ca_oscar.jsonl" "lm_es_oscar.jsonl" "lm_en_oscar.jsonl" "lm_id_oscar.jsonl" "lm_fr_oscar.jsonl" "lm_vi_oscar.jsonl" "lm_eu_oscar.jsonl")
DATASET_NAME=${LIST_DATASET[$SLURM_ARRAY_TASK_ID]}
echo $DATASET_NAME
DATASET_DIR="/gpfsscratch/rech/six/commun/bigscience-datasets/pii/pre"
SAVE_DATASET_DIR="/gpfsscratch/rech/six/commun/bigscience-datasets/pii/post/"$DATASET_NAME
SAVE_CHECKS_DATASET_DIR="/gpfsscratch/rech/six/commun/bigscience-datasets/pii/post_checks/"$DATASET_NAME
export HF_DATASETS_OFFLINE=1
export HF_DATASETS_CACHE=$SCRATCH/to_delete
conda activate lucile-pii
CATALOGUE_DATA_REPO="/gpfsdswork/projects/rech/six/uue59kq/repos/catalogue_data"
cd $CATALOGUE_DATA_REPO
python pii/pii_processor.py \
    --save-to-json \
    --save-check-to-json \
    --dataset-path $DATASET_DIR \
    --dataset-name $DATASET_NAME \
    --save-path $SAVE_DATASET_DIR \
    --save-check-path $SAVE_CHECKS_DATASET_DIR \
    --num-proc 40 \
    --batch-size 1000 \
    --save-batch-size 10000 \
    --check-sampling-size 10000 \
    --check-only-modified
