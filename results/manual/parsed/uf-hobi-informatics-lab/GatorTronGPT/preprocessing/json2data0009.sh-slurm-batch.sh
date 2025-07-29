#!/bin/bash
#SBATCH --job-name=json2data
#SBATCH --output=/red/gatortron-phi/gpt/logs/prep/j2d_%A_%a.out
#SBATCH --mail-user=alexgre@ufl.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --gpus-per-task=1
#SBATCH --mem=2000gb
#SBATCH --time=6-00:00:00
#SBATCH --array=0-9

root=/red/gatortron-phi/gpt
data_root=/red/gatortron-phi/gpt/data/ThePile_raw_json/the-eye.eu/public/AI/pile/train
vocab=${root}/vocab/gpt2-vocab.json
merge_file=${root}/vocab/gpt2-merges.txt
CONTAINER=${root}/containers/py2103.sif
i=$SLURM_ARRAY_TASK_ID
DATA=${data_root}/0${i}.jsonl
PREFIX=${root}/data/new_preprocessed_thepile/thepile_0${i}_bin
singularity exec --nv $CONTAINER python ${root}/Megatron-LM-2022/tools/preprocess_data.py \
        --input $DATA \
        --json-keys text \
        --tokenizer-type GPT2BPETokenizer \
        --vocab-file $vocab \
        --merge-file $merge_file \
        --output-prefix $PREFIX \
        --dataset-impl mmap \
        --workers 120 \
        --append-eod \
        --log-interval 10000
