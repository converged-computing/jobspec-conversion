#!/bin/bash
#SBATCH --account=Project_2000539
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:v100:1,nvme:10
#SBATCH --mem=6G
#SBATCH --time=1-00:00:00

export PYTORCH_PRETRAINED_BERT_CACHE='$TMPDIR'

module load pytorch/1.11
export PYTORCH_PRETRAINED_BERT_CACHE=$TMPDIR
PART=$1
PARTS=$2
DATAIN=$3 ## some .gz with sentences
DATAOUT=$4 ## where to store the embedded vectors
python3 embed_sbert.py --thisjob $PART --jobs $PARTS --in-file $DATAIN --bert-tokenizer sentence-transformers/paraphrase-multilingual-mpnet-base-v2 --sbert-model sentence-transformers/paraphrase-multilingual-mpnet-base-v2 --out $DATAOUT
