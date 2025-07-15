#!/bin/bash
#FLUX: --job-name=persnickety-peanut-butter-9089
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --priority=16

export PYTORCH_PRETRAINED_BERT_CACHE='$TMPDIR'

module load pytorch/1.11
export PYTORCH_PRETRAINED_BERT_CACHE=$TMPDIR
PART=$1
PARTS=$2
DATAIN=$3 ## some .gz with sentences
DATAOUT=$4 ## where to store the embedded vectors
python3 embed_sbert.py --thisjob $PART --jobs $PARTS --in-file $DATAIN --bert-tokenizer sentence-transformers/paraphrase-multilingual-mpnet-base-v2 --sbert-model sentence-transformers/paraphrase-multilingual-mpnet-base-v2 --out $DATAOUT
