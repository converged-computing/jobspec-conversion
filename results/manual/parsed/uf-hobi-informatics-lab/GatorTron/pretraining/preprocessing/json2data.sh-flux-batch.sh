#!/bin/bash
#FLUX: --job-name=json2data
#FLUX: -c=40
#FLUX: --gpus-per-task=1
#FLUX: --queue=hpg-ai
#FLUX: -t=43200
#FLUX: --urgency=16

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
