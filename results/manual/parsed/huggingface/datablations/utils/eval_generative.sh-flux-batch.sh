#!/bin/bash
#FLUX: --job-name=ornery-eagle-4636
#FLUX: -c=8
#FLUX: --exclusive
#FLUX: --queue=small-g
#FLUX: -t=172800
#FLUX: --urgency=16

export HF_DATASETS_OFFLINE='1'
export HF_DATASETS_CACHE='/scratch/project_462000119/ds_cache'

if [ -z $SLURM_JOB_ID ]; then
    mkdir -p logs
    sbatch "$0"
    exit
fi
set -euo pipefail
ln -f -s $SLURM_JOB_ID.out logs/latest_eval.out
ln -f -s $SLURM_JOB_ID.err logs/latest_eval.err
source /pfs/lustrep4/scratch/project_462000119/muennighoff/nov-2022-bettercom/venv/bin/activate
echo "START TIME: $(date)"
export HF_DATASETS_OFFLINE=1
export HF_DATASETS_CACHE=/scratch/project_462000119/ds_cache
CONFIGS=(
GEM/wiki_lingua_en,"tldr_en"
gem_xsum,"article_DOC_summary"
GEM/web_nlg_en,"PALM_prompt"
e2e_nlg_cleaned,"generate_text_restaurant"
)
CKPTS=(
/pfs/lustrep4/scratch/project_462000119/muennighoff/nov-2022-bettercom/lm1-4b2-84b-c4-repetitions/4b284b6bc4/transformers
/pfs/lustrep4/scratch/project_462000119/muennighoff/nov-2022-bettercom/lm1-4b2-84b-c4-repetitions/4b284b1b9c4/transformers
)
FEWSHOT_CONFIGS=(
0
1
2
3
4
5
)
TOKENIZER=/pfs/lustrep4/scratch/project_462000119/muennighoff/nov-2022-bettercom/gpt2
for ((i=0; i<${#CKPTS[@]}; i++)); do
    for ((j=0; j<${#FEWSHOT_CONFIGS[@]}; j++)); do
        for ((k=0; k<${#CONFIGS[@]}; k++)); do
            #echo "sbatch --export=CKPT=${CKPTS[$i]},FEWSHOT_CONFIG=${FEWSHOT_CONFIGS[$j]},DATASET=${DATASETS[$k]} eval.sh"
            DATA_CONFIG=${CONFIGS[$k]}
            IFS=',' read dataset_name template_name x <<< "${DATA_CONFIG}"
            MODEL_CKPT=${CKPTS[$i]}
            MODEL_CKPT_NO_TRF=${MODEL_CKPT%/*}
            MODEL_NAME=${MODEL_CKPT_NO_TRF##*/}
            OUTPUT_PATH=$MODEL_CKPT_NO_TRF/evaluation/generation
            mkdir -p $OUTPUT_PATH
            OUTPUT_NAME=$MODEL_NAME\_$dataset_name\_$template_name\_${FEWSHOT_CONFIGS[$j]}
            eval_script="./eval_$i-$j-$k.slurm"
            cat <<EOT > $eval_script
set -euo pipefail
ln -f -s "\$SLURM_JOB_ID.out" logs/latest_eval.out
ln -f -s "\$SLURM_JOB_ID.err" logs/latest_eval.err
source /pfs/lustrep4/scratch/project_462000119/muennighoff/nov-2022-bettercom/venv/bin/activate
echo "START TIME: $(date)"
export HF_DATASETS_OFFLINE=1
export HF_DATASETS_CACHE=/scratch/project_462000119/ds_cache
cd /pfs/lustrep4/scratch/project_462000119/muennighoff/nov-2022-bettercom/bigscience/lm-evaluation-harness
python main.py \
    --model_api_name 'hf-causal' \
    --model_args pretrained=${CKPTS[$i]},use_accelerate=True,tokenizer=$TOKENIZER,dtype=bfloat16 \
    --device cuda \
    --batch_size 4 \
    --no_tracking \
    --task_name $dataset_name \
    --template_names "$template_name" \
    --bootstrap_iters 10 \
    --limit 3000 \
    --num_fewshot ${FEWSHOT_CONFIGS[$j]} \
    --output_dir $OUTPUT_PATH \
    --output_path "$OUTPUT_NAME"
python main.py \
    --model_api_name 'hf-causal' \
    --model_args pretrained=${CKPTS[$i]},use_accelerate=True,tokenizer=$TOKENIZER,dtype=bfloat16 \
    --device cuda \
    --batch_size 2 \
    --no_tracking \
    --task_name $dataset_name \
    --template_names "$template_name" \
    --bootstrap_iters 10 \
    --limit 3000 \
    --num_fewshot ${FEWSHOT_CONFIGS[$j]} \
    --output_dir $OUTPUT_PATH \
    --output_path "$OUTPUT_NAME"
echo "END TIME: $(date)"
EOT
            # Submit the job
            sbatch $eval_script
            # Sleep for a bit to avoid hitting the job submission limit
            sleep 0.1
        done
    done
done
echo "END TIME: $(date)"
