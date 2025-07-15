#!/bin/bash
#FLUX: --job-name=eval
#FLUX: --urgency=16

export dataset='empathetic'
export dataset_dir='data/${dataset}'
export task='us'
export seed='345678'
export model_path='output/${dataset}-${task}-${seed}'
export checkpoint_number='best.pt'
export lm_path='SRoBERTa'

export dataset=empathetic
export dataset_dir=data/${dataset}
export task=us
export seed=345678
export model_path=output/${dataset}-${task}-${seed}
export checkpoint_number=best.pt
export lm_path=SRoBERTa
echo "evaluate ${dataset}-${task}"
python -u eval.py \
        --data=${dataset_dir}/${dataset}_${task}.pkl \
        --device=cuda \
        --batch_size=512 \
        --model_name_or_path ${lm_path} \
        --wp 4 \
        --wf 4 \
        --model_save_path ${model_path} \
        --oot_model ${checkpoint_number}
