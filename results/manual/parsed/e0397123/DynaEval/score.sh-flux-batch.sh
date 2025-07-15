#!/bin/bash
#FLUX: --job-name=score
#FLUX: --priority=16

export dataset='feddial'
export dataset_dir='data/${dataset}'
export checkpoint_number='best.pt'
export lm_path='SRoBERTa'
export model_save_path='output/empathetic-us-345678/'
export checkpoint_name='best.pt'

export dataset=feddial
export dataset_dir=data/${dataset}
export checkpoint_number=best.pt
export lm_path=SRoBERTa
export model_save_path=output/empathetic-us-345678/
export checkpoint_name=best.pt
python -u score.py \
        --data=${dataset_dir}/${dataset}_eval.pkl \
        --device=cuda \
        --batch_size=1 \
        --model_name_or_path ${lm_path} \
        --wp 4 \
        --wf 4 \
        --model_save_path ${model_save_path} \
        --oot_model ${checkpoint_name}
