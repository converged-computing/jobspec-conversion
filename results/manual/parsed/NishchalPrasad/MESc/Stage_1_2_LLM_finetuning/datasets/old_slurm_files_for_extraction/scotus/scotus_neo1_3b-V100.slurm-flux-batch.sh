#!/bin/bash
#FLUX: --job-name=ext_cls_GPT-Neo-1_3b
#FLUX: -c=24
#FLUX: --queue=gpu_p4
#FLUX: -t=72000
#FLUX: --urgency=16

export PATH='$WORK/.local/bin:$PATH'

module purge
set -x
module load python
export PATH=$WORK/.local/bin:$PATH
accelerate launch --config_file LEGAL-PE/SIGIR_experiments/distributedTraining/Config_files_for_distributed/default_accelerate_config_without_deep_speed.yaml LEGAL-PE/SIGIR_experiments/datasets/extract_CLS_embeds_after_finetuning_.py \
        --maxlen 128 \
        --length 126 \
        --overlap 25 \
        --loading_model_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/scotus/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/torch-model_epoch-1.pth" \
        --cuda_number 0 \
        --strat 0 \
        --dataset_subset "scotus" \
        --hggfc_model_name 'EleutherAI/gpt-neo-1.3B' \
        --get_train_data True \
        --get_validation_data True \
        --get_test_data True \
        --trained_without_accelerate True \
        --path_train_dat "LEGAL-P_E/SIGIR_experiments/finetuned_models/scotus/Extracted_data/from_512input_ft_model/128_input_len_25_overlap/Neo1.3b/"
