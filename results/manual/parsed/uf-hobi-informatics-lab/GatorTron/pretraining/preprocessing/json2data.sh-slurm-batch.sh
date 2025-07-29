#!/bin/bash
#SBATCH --job-name=json2data
#SBATCH --output=./j2d_%j.out
#SBATCH --mail-user=USER@DOMAIN
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --gpus-per-task=1
#SBATCH --mem=512gb
#SBATCH --time=12:00:00

pwd; hostname; date
echo "Pipeline task on processing json to data bin"
KEY='NOTE_TEXT'
CONTAINER=./containers/pytorch.sif # we need a container without megatron installed
VOCAB=./vocab.txt
for i in $(seq 1 21)
do 
    DATA=./data/note_txt_${i}.json
    PREFIX=./data/bin/note_txt_${i}
    singularity exec --nv $CONTAINER python ./Megatron-LM/tools/preprocess_data.py \
        --input $DATA \
        --json-keys $KEY \
        --split-sentences \
        --tokenizer-type BertWordPieceCase \
        --vocab-file $VOCAB \
        --output-prefix $PREFIX \
        --dataset-impl mmap \
        --workers 32 \
        --log-interval 1000
done
date
