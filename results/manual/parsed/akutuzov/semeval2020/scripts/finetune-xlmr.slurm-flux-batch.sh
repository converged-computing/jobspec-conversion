#!/bin/bash
#FLUX: --job-name=XLMR
#FLUX: -n=4
#FLUX: -c=6
#FLUX: --queue=accel
#FLUX: -t=216000
#FLUX: --urgency=16

umask 0007
module use -a /fp/projects01/ec30/software/easybuild/modules/all/
module purge   # Recommended for reproducibility
module load nlpl-datasets/1.17-foss-2019b-Python-3.7.4
module load nlpl-transformers/4.14.1-foss-2019b-Python-3.7.4
module list
language=${1}
model=xlm-roberta-base
epochs=2
bsz=16
max_seq_len=256
python3 -m torch.distributed.launch --nproc_per_node=4 --nnodes=1 --node_rank=0  \
        ../code/xlmr/finetune_mlm.py \
        --train_file finetuning_corpora/$language/token/all.txt.gz \
        --targets_file targets/$language/target_forms_udpipe.csv \
        --output_dir finetuned_models/$language \
        --do_train \
        --do_eval \
        --save_steps 100000000 \
        --fp16 \
        --num_train_epochs $epochs \
        --per_device_train_batch_size $bsz \
        --model_name_or_path $model \
        --overwrite_output_dir \
        --max_seq_len $max_seq_len
