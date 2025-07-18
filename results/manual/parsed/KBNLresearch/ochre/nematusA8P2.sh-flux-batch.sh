#!/bin/bash
#FLUX: --job-name=nematus_kb-ocr
#FLUX: -t=300
#FLUX: --urgency=16

srun mkdir -p /var/scratch/jvdzwaan/kb-ocr/A8P2/model/
srun python ~/code/nematus/nematus/train.py --source_dataset /var/scratch/jvdzwaan/kb-ocr/A8P2/train.ocr --target_dataset /var/scratch/jvdzwaan/kb-ocr/A8P2/train.gs --embedding_size 256 --tie_encoder_decoder_embeddings --rnn_use_dropout --batch_size 100 --valid_source_dataset /var/scratch/jvdzwaan/kb-ocr/A8P2/val.ocr --valid_target_dataset /var/scratch/jvdzwaan/kb-ocr/A8P2/val.gs --dictionaries /var/scratch/jvdzwaan/kb-ocr/A8P1/train.json /var/scratch/jvdzwaan/kb-ocr/A8P1/train.json --valid_batch_size 100 --model /var/scratch/jvdzwaan/kb-ocr/A8P2/model/model --reload latest_checkpoint --save_freq 10000
