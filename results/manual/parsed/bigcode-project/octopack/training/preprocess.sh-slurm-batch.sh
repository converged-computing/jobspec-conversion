#!/bin/bash
#SBATCH --job-name=jsonl
#SBATCH --account=cnw@cpu
#SBATCH --output=%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --time=05:00:00
#SBATCH --partition=cpu_p1

OUTPUT=/gpfswork/rech/ajs/commun/code/bigcode/finetune/train
TOKENIZER_FILE=/gpfswork/rech/ajs/commun/code/bigcode/bigcode-evaluation-harness/santacoder/tokenizer.json
OUTPUT=/gpfswork/rech/ajs/commun/code/bigcode/finetune/train_bigcode
TOKENIZER_FILE=/gpfsscratch/rech/ajs/commun/large-model/tokenizer.json
OUTPUT=/gpfsscratch/rech/ajs/commun/train_commits8192
TOKENIZER_FILE=/gpfsscratch/rech/ajs/commun/large-model/tokenizer.json
OUTPUT=my_dataset_output_name
TOKENIZER_FILE=/path/to/tokenizer.json
INPUT=/path/to/my_dataset.jsonl
sort -u $INPUT.jsonl | shuf > dedup.jsonl
cd /gpfswork/rech/ajs/commun/code/bigcode/finetune/Megatron-LM
python tools/preprocess_data.py \
    --input /gpfsscratch/rech/ajs/commun/dedup.jsonl \
    --output-prefix $OUTPUT \
    --dataset-impl mmap \
    --json-key inputs \
    --tokenizer-type TokenizerFromFile \
    --tokenizer-file $TOKENIZER_FILE \
    --workers 30 \
    --chunk-size 1000
python tools/preprocess_data.py \
    --input /gpfsscratch/rech/ajs/commun/dedup.jsonl \
    --output-prefix $OUTPUT \
    --dataset-impl mmap \
    --json-key targets \
    --tokenizer-type TokenizerFromFile \
    --tokenizer-file $TOKENIZER_FILE \
    --workers 30 \
    --chunk-size 1000
